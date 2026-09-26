// Our stream endpoints are POST, and the browser's EventSource is GET-only with no
// body, so this reads the same "data: ...\n\n" SSE framing by hand off fetch().
export async function readSSE(res: Response, onData: (payload: string) => void) {
  if (!res.ok || !res.body) throw new Error(`${res.status}: ${await res.text()}`);

  const reader = res.body.getReader();
  const decoder = new TextDecoder();
  let buffer = "";

  while (true) {
    const { done, value } = await reader.read();
    if (done) break;

    buffer += decoder.decode(value, { stream: true });
    const messages = buffer.split("\n\n");
    buffer = messages.pop() ?? ""; // last chunk may be incomplete, keep it for next read

    for (const message of messages) onData(message.replace(/^data: /, ""));
  }
}
