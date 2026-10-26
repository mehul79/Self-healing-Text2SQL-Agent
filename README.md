# Self-Healing Text-to-SQL Assistant

## Description

Ask a question in plain English and get back SQL, the rows it returns, and a short answer. If the generated SQL fails validation or errors out in Postgres, the assistant reads the error, repairs the query, and tries again, up to three times.

I built this to learn the stack behind LLM agents by building one. Most text-to-SQL demos stop at "LLM writes a query". The harder part is what happens when that query is wrong: a table name that doesn't exist, a column on the wrong table, or a statement that should never run. This project handles those cases in code rather than hoping the prompt covers them.

What I learned building it:

- Python packaging: `__init__.py`, absolute imports.
- FastAPI: Pydantic request/response models, routers, `Depends`, streaming responses
- Swapping LLM providers through env vars without touching code
- asyncio: what actually runs concurrently, and keeping sync DB calls from blocking the event loop
- LangGraph: typed shared state, conditional edges, and a bounded retry loop
- SQLAlchemy: engines, sessions, pooling, and reflecting an existing schema
- Why the LLM should never be the security boundary

## Table of Contents

- [How It Works](#how-it-works)
- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [Tests](#tests)
- [Benchmark](#benchmark)
- [Project Layout](#project-layout)
- [UI Demo](#ui-demo)
- [Future Updates](#future-updates)
- [Credits](#credits)
- [License](#license)

## How It Works

The agent is a LangGraph state machine. Each node reads and updates a shared typed state (`backend/graph/state.py`).

![LangGraph agent graph](backend/graph/graph.png)

1. **understand** and **retrieve_schema** load the question and the live database schema.
2. **generate_sql** asks the LLM for a query, using structured output (`sql`, `tables_used`, `reasoning`).
3. **validate** parses the SQL with `sqlglot` and rejects anything that isn't a single `SELECT` or `WITH ... SELECT`, plus unknown tables and columns.
4. **execute_sql** runs the query as a read-only Postgres role, with a 5s statement timeout and a 1000-row cap.
5. If validation or execution fails, **diagnose_error** classifies the error and **repair_sql** asks the LLM to fix it, then the query goes back through validation.
6. **respond** returns the result, or gives up after 3 repair attempts.

## Features

- Natural language to PostgreSQL over the [Chinook](https://github.com/lerocha/chinook-database) sample database
- Self-repair loop driven by real validation and database errors
- SQL allowlisting in application code, tested independently of any prompt
- Read-only database role, even in development
- Any OpenAI-compatible LLM provider, chosen by env vars
- Server-sent event stream of each graph step as it runs
- Saved chats with follow-up questions ("only rock", "now compare with 2022")
- Next.js chat UI with a live status line, a Stop button, SQL highlighting, and a repair timeline

## Installation

Requirements: Python 3.14, [uv](https://docs.astral.sh/uv/), Docker, Node.js.

1. Clone the repo and install Python dependencies:

   ```bash
   git clone https://github.com/mehul79/Self-healing-Text2SQL-Agent.git
   cd Self-healing-Text2SQL-Agent
   uv sync
   ```

2. Copy `.env.example` to `.env` and fill in the Postgres credentials, the read-only user, and your LLM provider's `BASE_URL`, `LLM_API_KEY`, and `MODEL_NAME`.

3. Start Postgres:

   ```bash
   docker compose up -d
   ```

4. Load the Chinook schema and data. Download `Chinook_PostgreSql.sql` from the [Chinook repo](https://github.com/lerocha/chinook-database) into `seed/` (it's gitignored), then load it as the owner user:

   ```bash
   docker compose exec -T postgres psql -U <POSTGRES_USER> -d <POSTGRES_DB> < seed/Chinook_PostgreSql.sql
   ```

5. Create the read-only role the app connects as:

   ```sql
   CREATE ROLE readonly_user WITH LOGIN PASSWORD '<your_readonly_password>';
   GRANT CONNECT ON DATABASE <POSTGRES_DB> TO readonly_user;
   GRANT USAGE ON SCHEMA public TO readonly_user;
   GRANT SELECT ON ALL TABLES IN SCHEMA public TO readonly_user;
   ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO readonly_user;
   ```

6. Create the chat store: a separate database, owned by a role that can write there and can't connect to Chinook. Run these one at a time in `psql` as the owner user (`CREATE DATABASE` can't run inside a transaction):

   ```sql
   CREATE ROLE app_writer WITH LOGIN PASSWORD '<your_app_writer_password>';
   CREATE DATABASE text2sql_app OWNER app_writer;
   REVOKE CONNECT ON DATABASE text2sql_app FROM PUBLIC;
   REVOKE CONNECT ON DATABASE <POSTGRES_DB> FROM PUBLIC;
   GRANT CONNECT ON DATABASE <POSTGRES_DB> TO readonly_user;
   ```

   The API creates the chat tables on startup.

7. Install frontend dependencies:

   ```bash
   cd frontend
   npm install
   ```

## Usage

Start the API from the repo root, so `backend` resolves as a package:

```bash
uv run uvicorn backend.api.main:app --reload
```

Interactive docs are at http://127.0.0.1:8000/docs.

| Method | Path | Purpose |
| --- | --- | --- |
| `GET` | `/api/health` | Liveness check |
| `GET` | `/api/schema` | Reflected tables, columns, and foreign keys |
| `GET` | `/api/model/list` | Models your configured provider serves |
| `POST` | `/api/query` | Run a question through the graph and return the result |
| `GET` | `/api/query/{query_id}` | Fetch a previous result |
| `POST` | `/api/query/stream` | Same as `/api/query`, streamed step by step as SSE |
| `POST` | `/api/chats` | Start a new chat |
| `GET` | `/api/chats` | List chats, most recently updated first |
| `GET` | `/api/chats/{chat_id}` | Fetch a chat with its messages |
| `DELETE` | `/api/chats/{chat_id}` | Delete a chat and its messages |
| `POST` | `/api/chats/{chat_id}/messages/stream` | Ask a question in a chat, with earlier turns as context. Streams SSE like `/api/query/stream` and saves both messages |

Example:

```bash
curl -X POST http://127.0.0.1:8000/api/query \
  -H "Content-Type: application/json" \
  -d '{"question": "How many tracks are in the database?"}'
```

Start the frontend in a second terminal:

```bash
cd frontend
npm run dev
```

Then open http://localhost:3000.

To run the graph directly and watch it repair a query that is broken on purpose:

```bash
uv run python -m backend.graph.build
```

## Tests

Each ported module has a runnable self-check. Run them from the repo root:

```bash
uv run python -m backend.security.test_security   # SQL allowlist: stacked statements, DELETE in a CTE, etc.
uv run python -m backend.security.sql_guard       # validator self-check
uv run python -m backend.database.connection      # read-only DB connection
uv run python -m backend.api.routers.chats        # chat store: create, list, fetch, delete, cascade
uv run python -m backend.graph.build              # end-to-end graph run, including a forced repair
```

The security tests need no database or LLM. The rest need Postgres running, and the graph run also needs a working LLM provider.

## Benchmark

Execution accuracy on the [Spider](https://yale-lily.github.io/spider) dev set (1,034 questions, 20 SQLite databases), scored by Spider's official [test-suite evaluator](https://github.com/taoyds/test-suite-sql-eval). Both models via OpenRouter. Final answers, with the repair loop on (up to 3 repairs):

<picture>
  <source srcset="docs/benchmark-dark.png" media="(prefers-color-scheme: dark)">
  <img alt="Spider dev execution accuracy by difficulty for Llama 3.1 8B, Gemma 3 12B, and Gemma 3 12B with the upgrades; first attempts solid, points added by the repair loop hatched" src="docs/benchmark-light.png">
</picture>

| Model | Easy (248) | Medium (446) | Hard (174) | Extra (166) | **All (1,034)** |
| --- | --- | --- | --- | --- | --- |
| `meta-llama/llama-3.1-8b-instruct` | 85.9 | 71.7 | 43.7 | 38.0 | **65.0** |
| `google/gemma-3-12b-it` | 90.3 | 84.8 | 62.1 | 51.8 | **77.0** |
| `google/gemma-3-12b-it` + upgrades | 90.3 | 84.8 | 73.0 | 58.4 | **79.9** |

First attempts only, from the same runs with the repairs removed:

| Model | Easy | Medium | Hard | Extra | All | Repair adds |
| --- | --- | --- | --- | --- | --- | --- |
| `meta-llama/llama-3.1-8b-instruct` | 83.9 | 69.5 | 43.1 | 37.3 | 63.3 | +1.7 |
| `google/gemma-3-12b-it` | 90.3 | 83.9 | 60.9 | 48.2 | 75.8 | +1.2 |
| `google/gemma-3-12b-it` + upgrades | 89.5 | 84.8 | 71.8 | 56.6 | 79.2 | +0.7 |

Run details:

| Model | Temperature | Needed repair | Recovered | Gave up | Median per question | Cost |
| --- | --- | --- | --- | --- | --- | --- |
| `meta-llama/llama-3.1-8b-instruct` | 0.2 | 96 | 50 | 47 | 1.3s | $0.11 |
| `google/gemma-3-12b-it` | 0 | 36 | 21 | 15 | 4.9s | about $0.06 |
| `google/gemma-3-12b-it` + upgrades | 0 | 102 | 95 | 7 | 5.8s | about $0.07 |

- **Gemma 3 12B beats Llama 3.1 8B by 12 points.** The gap is small on easy questions (about 4 points) and large on hard and extra ones (18 and 14 points).
- **The repair loop adds little.** It adds +1.2 points for Gemma and +1.7 for Llama. Gemma needed far fewer repairs (36 against 96) and recovered a higher share of them.
- **Repair fixes queries that fail, not queries that are wrong.** Llama's 96 repairs were mostly unknown columns (88). 50 recovered to SQL that runs, but only about 18 of those returned the right rows; 45 still failed after 3 repairs.
- A question the agent gives up on is scored as no answer, since the app returns no rows for it.
- The Gemma run used the fixed validator (read-only `INTERSECT` / `UNION` / `EXCEPT` are accepted) at `TEMPERATURE=0`. The Llama run used `TEMPERATURE=0.2`, so the two aren't a perfectly controlled comparison.
- Gemma's cost is estimated from its token counts at OpenRouter's list price. Llama's is the earlier figure.
- **The upgrades add 2.9 points, almost all on hard and extra questions.** They are the richer schema (primary keys, join paths, and up to 3 sample values per text column), "did you mean" hints for unknown columns, and a result check that gives an empty or NULL-only result one more repair try. First attempts rose from 75.8 to 79.2, mostly on hard (+10.9) and extra (+8.4) questions. The hints and the result check act only during repair, so the first-attempt gain comes from the schema.
- **The result check added nothing measurable.** It flagged 78 questions. By a rough row-match against the gold SQL it fixed 4 and broke 4, and 38 of the 78 were already correct. On Spider train gold SQL, 14.8% of correct queries return no rows, which is why an empty-result rule is noisy.
- The richer schema costs about 51% more input tokens (1.0M against 0.67M per run).

## Project Layout

```
backend/
  api/        FastAPI app and routers (schema, models, query, chats)
  chats/      chat store: ORM models and its own writable engine
  database/   read-only engine, sessions, query execution
  eval/       Spider benchmark: the graph on SQLite files, plus the runner
  graph/      LangGraph state, nodes, and graph wiring
  llm/        provider-agnostic LLM client
  security/   SQL allowlist validator and its tests
frontend/     Next.js UI
notebooks/    prototypes: SQLAlchemy, asyncio, LangGraph, chats, Spider
```

## UI Demo

A saved chat: the collapsed step trail, the generated SQL with a copy button, and the result rows.

![Chat with a multi-join query and its results](docs/ui-chat.png)

A new chat. Saved chats are in the sidebar, and the schema browser opens from the header.

![Empty new chat with the chat sidebar](docs/ui-new-chat.png)

## Credits

- [Chinook sample database](https://github.com/lerocha/chinook-database)
- [Spider Dataset](https://yale-lily.github.io/spider)
- Built with [FastAPI](https://fastapi.tiangolo.com/), [LangGraph](https://langchain-ai.github.io/langgraph/), [SQLAlchemy](https://www.sqlalchemy.org/), [sqlglot](https://github.com/tobymao/sqlglot), [Next.js](https://nextjs.org/), and [shadcn/ui](https://ui.shadcn.com/)

## License

[MIT](LICENSE)
