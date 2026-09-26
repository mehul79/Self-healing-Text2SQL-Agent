export type NodeName =
  | "understand"
  | "retrieve_schema"
  | "generate_sql"
  | "validate"
  | "execute_sql"
  | "diagnose_error"
  | "repair_sql"
  | "respond";

// one SSE event per finished graph node, as sent by /api/chats/{id}/messages/stream
export type StreamNodeEvent = {
  node: NodeName;
  data: Record<string, unknown>;
};

// mirrors ChatSummary / ChatDetail / MessageOut in backend/api/routers/chats.py
export type ChatSummary = {
  id: string;
  title: string;
  created_at: string;
  updated_at: string;
};

export type ChatMessage = {
  id: number;
  role: "user" | "assistant";
  content: string;
  sql: string | null;
  rows: Record<string, unknown>[] | null;
  status: "ok" | "failed" | "stopped" | null;
  attempts: number | null;
  events: StreamNodeEvent[] | null;
  created_at: string;
};

export type ChatDetail = ChatSummary & { messages: ChatMessage[] };

async function api<T>(path: string, init?: RequestInit): Promise<T> {
  const res = await fetch(path, init);
  if (!res.ok) throw new Error(`${res.status}: ${(await res.text()).slice(0, 200)}`);
  return (res.status === 204 ? undefined : await res.json()) as T;
}

export const listChats = () => api<ChatSummary[]>("/api/chats");
export const getChat = (id: string) => api<ChatDetail>(`/api/chats/${id}`);
export const createChat = () => api<ChatSummary>("/api/chats", { method: "POST" });
export const deleteChat = (id: string) => api<void>(`/api/chats/${id}`, { method: "DELETE" });
