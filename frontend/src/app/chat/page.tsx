"use client";

import { useEffect } from "react";
import { ArrowUpIcon } from "lucide-react";
import { ChatMessage } from "@/components/chat-message";
import { ChatSidebar } from "@/components/chat-sidebar";
import { ModeToggle } from "@/components/mode-toggle";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import {
  MessageScroller,
  MessageScrollerButton,
  MessageScrollerContent,
  MessageScrollerItem,
  MessageScrollerProvider,
  MessageScrollerViewport,
} from "@/components/ui/message-scroller";
import { SidebarInset, SidebarProvider, SidebarTrigger } from "@/components/ui/sidebar";
import { useChatsStore } from "@/store/chats";

export default function ChatPage() {
  const { active, error, loadChats } = useChatsStore();

  useEffect(() => {
    loadChats();
  }, [loadChats]);

  return (
    <SidebarProvider>
      <ChatSidebar />
      <SidebarInset className="h-svh">
        <header className="flex items-center gap-2 border-b px-4 py-3">
          <SidebarTrigger />
          <h1 className="truncate font-heading text-sm font-medium">{active?.title ?? "Text2SQL"}</h1>
          <div className="ml-auto">
            <ModeToggle />
          </div>
        </header>

        {error && <p className="px-4 pt-3 text-sm text-destructive">{error}</p>}

        <div className="min-h-0 flex-1">
          {!active || active.messages.length === 0 ? (
            <div className="flex h-full flex-col items-center justify-center gap-1 px-6 text-center">
              <p className="font-heading font-medium">Ask a question about the database</p>
              <p className="text-sm text-muted-foreground">
                The agent writes the SQL, runs it read-only, and repairs it if it fails.
              </p>
            </div>
          ) : (
            // key: a different chat is a fresh scroll position, not a continuation
            <MessageScrollerProvider key={active.id}>
              <MessageScroller>
                <MessageScrollerViewport>
                  <MessageScrollerContent className="mx-auto w-full max-w-3xl px-4 py-6">
                    {active.messages.map((m) => (
                      <MessageScrollerItem key={m.id} scrollAnchor={m.role === "user"}>
                        <ChatMessage message={m} />
                      </MessageScrollerItem>
                    ))}
                  </MessageScrollerContent>
                </MessageScrollerViewport>
                <MessageScrollerButton />
              </MessageScroller>
            </MessageScrollerProvider>
          )}
        </div>

        {/* sending is day 5 block 7: the store gets a send action wired to the stream hook */}
        <form className="mx-auto flex w-full max-w-3xl gap-2 px-4 pb-4" onSubmit={(e) => e.preventDefault()}>
          <Input placeholder="Sending comes in the next step" disabled />
          <Button type="submit" size="icon" disabled aria-label="Send">
            <ArrowUpIcon />
          </Button>
        </form>
      </SidebarInset>
    </SidebarProvider>
  );
}
