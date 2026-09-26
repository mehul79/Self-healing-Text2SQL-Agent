import { Marker, MarkerContent } from "@/components/ui/marker";
import type { StreamNodeEvent } from "@/lib/chats";

function lastError(event: StreamNodeEvent): string | null {
  const errors = (event.data.errors as string[] | undefined) ?? [];
  return errors.length ? errors[errors.length - 1] : null;
}

const hasErrors = (event: StreamNodeEvent) => lastError(event) !== null;

// Past tense, one line per finished node: the trail shown under a finished reply.
export function stepLabel(event: StreamNodeEvent): { text: string; failed: boolean } {
  const error = lastError(event);
  switch (event.node) {
    case "understand":
      return { text: "Read your question", failed: false };
    case "retrieve_schema":
      return { text: "Read the database schema", failed: false };
    case "generate_sql":
      return { text: "Wrote the SQL query", failed: false };
    case "validate":
      return error ? { text: `Safety check failed: ${error}`, failed: true } : { text: "Checked the query is safe", failed: false };
    case "execute_sql":
      return error ? { text: `Query failed: ${error}`, failed: true } : { text: "Ran the query", failed: false };
    case "diagnose_error":
      return { text: "Worked out what went wrong", failed: false };
    case "repair_sql":
      return { text: "Fixed the query", failed: false };
    case "respond":
      return { text: "Wrote the answer", failed: false };
  }
}

export function StepTrail({ events }: { events: StreamNodeEvent[] }) {
  if (events.length === 0) return null;
  const repairs = events.filter((e) => e.node === "repair_sql").length;

  return (
    <details className="group text-xs text-muted-foreground">
      <summary className="w-fit cursor-pointer list-none hover:text-foreground [&::-webkit-details-marker]:hidden">
        {events.length} steps{repairs > 0 && ` · ${repairs} repair${repairs === 1 ? "" : "s"}`}
        <span className="ml-1 inline-block transition-transform group-open:rotate-90">›</span>
      </summary>
      <ol className="mt-2 flex flex-col gap-1 border-l pl-3">
        {events.map((event, i) => {
          const { text, failed } = stepLabel(event);
          return (
            <li key={i} className={failed ? "text-destructive" : undefined}>
              {text}
            </li>
          );
        })}
      </ol>
    </details>
  );
}

// Events arrive when a node *finishes*, so the phrase names the step that runs next.
export function statusPhrase(events: StreamNodeEvent[]): string {
  const last = events[events.length - 1];
  if (!last) return "Reading your question";
  switch (last.node) {
    case "understand":
      return "Reading the database schema";
    case "retrieve_schema":
      return "Writing the SQL query";
    case "generate_sql":
    case "repair_sql":
      return "Checking the query is safe";
    case "validate":
      return hasErrors(last) ? "Working out what went wrong" : "Running the query";
    case "execute_sql":
      return hasErrors(last) ? "Working out what went wrong" : "Writing the answer";
    case "diagnose_error":
      return "Fixing the query";
    case "respond":
      return "Writing the answer";
  }
}

export function ChatStatus({ events }: { events: StreamNodeEvent[] }) {
  const repairs = events.filter((e) => e.node === "repair_sql").length;
  return (
    <Marker aria-live="polite">
      <MarkerContent className="shimmer">
        {statusPhrase(events)}…{repairs > 0 && ` (repair ${repairs})`}
      </MarkerContent>
    </Marker>
  );
}
