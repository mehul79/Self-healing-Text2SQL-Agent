import { Badge } from "@/components/ui/badge";
import { Bubble, BubbleContent } from "@/components/ui/bubble";
import { Marker, MarkerContent } from "@/components/ui/marker";
import { Message, MessageContent } from "@/components/ui/message";
import { StepTrail } from "@/components/chat-status";
import { RepairTimeline } from "@/components/repair-timeline";
import { ResultsTable } from "@/components/results-table";
import { SqlHighlight } from "@/components/sql-highlight";
import type { ChatMessage as ChatMessageType } from "@/lib/chats";

export function ChatMessage({ message }: { message: ChatMessageType }) {
  if (message.role === "user") {
    return (
      <Message align="end">
        <MessageContent>
          <Bubble align="end">
            <BubbleContent>{message.content}</BubbleContent>
          </Bubble>
        </MessageContent>
      </Message>
    );
  }

  const attempts = message.attempts ?? 0;

  // the hand-built pieces from day four move in unchanged; the library only draws the row
  return (
    <Message>
      <MessageContent>
        {message.events && <StepTrail events={message.events} />}

        {message.status === "stopped" ? (
          <Marker>
            <MarkerContent>Stopped before an answer.</MarkerContent>
          </Marker>
        ) : (
          <Bubble variant={message.status === "failed" ? "destructive" : "ghost"}>
            <BubbleContent>{message.content}</BubbleContent>
          </Bubble>
        )}

        {attempts > 0 && (
          <Badge variant="outline" className="w-fit">
            {attempts} repair{attempts === 1 ? "" : "s"}
          </Badge>
        )}

        {message.sql && <SqlHighlight sql={message.sql} />}
        {message.rows && <ResultsTable rows={message.rows} />}
        {message.events && <RepairTimeline events={message.events} />}
      </MessageContent>
    </Message>
  );
}
