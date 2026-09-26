"use client";

import { useEffect, useState } from "react";
import { ArrowUpIcon, DatabaseIcon, SquareIcon } from "lucide-react";
import { ChatMessage } from "@/components/chat-message";
import { ChatSidebar } from "@/components/chat-sidebar";
import { ChatStatus } from "@/components/chat-status";
import { ModeToggle } from "@/components/mode-toggle";
import { SchemaBrowser } from "@/components/schema-browser";
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
import { Sheet, SheetContent, SheetHeader, SheetTitle, SheetTrigger } from "@/components/ui/sheet";
import { SidebarInset, SidebarProvider, SidebarTrigger } from "@/components/ui/sidebar";
import { useChatsStore } from "@/store/chats";

// matches the input's h-12 so the two line up
const SEND_BUTTON = "size-12 shrink-0 rounded-xl [&_svg:not([class*='size-'])]:size-5";

export default function ChatPage() {
  const { active, error, pending, loadChats, newChat, send, stop } = useChatsStore();
  const [question, setQuestion] = useState("");

  useEffect(() => {
    loadChats();
  }, [loadChats]);

  // Cmd+Shift+O on macOS, Ctrl+Shift+O elsewhere: same shortcut ChatGPT uses.
  // e.code, not e.key: with Shift held, e.key is "O" and varies by keyboard layout.
  useEffect(() => {
    const onKeyDown = (e: KeyboardEvent) => {
      if ((e.metaKey || e.ctrlKey) && e.shiftKey && e.code === "KeyO") {
        e.preventDefault(); // Chrome would otherwise open the bookmark manager
        newChat();
      }
    };
    window.addEventListener("keydown", onKeyDown);
    return () => window.removeEventListener("keydown", onKeyDown);
  }, [newChat]);

  const streamingHere = pending !== null && pending.chatId === active?.id;

  return (
    <SidebarProvider>
      <ChatSidebar />
      <SidebarInset className="h-svh">
        <header className="flex items-center gap-2 border-b px-4 py-3">
          <SidebarTrigger />
          <h1 className="truncate font-heading text-sm font-medium">{active?.title ?? "Text2SQL"}</h1>
          <div className="ml-auto flex items-center gap-1">
            <Sheet>
              <SheetTrigger render={<Button variant="ghost" size="sm" />}>
                <DatabaseIcon />
                Schema
              </SheetTrigger>
              <SheetContent className="overflow-y-auto data-[side=right]:sm:max-w-xl">
                <SheetHeader>
                  <SheetTitle>Tables you can ask about</SheetTitle>
                </SheetHeader>
                <div className="px-4 pb-4">
                  <SchemaBrowser />
                </div>
              </SheetContent>
            </Sheet>
            <ModeToggle />
          </div>
        </header>

        {error && <p className="px-4 pt-3 text-sm text-destructive">{error}</p>}

        {/* the scroll area runs to the bottom of the window; the input floats over it */}
        <div className="relative min-h-0 flex-1">
          {!active || (active.messages.length === 0 && !streamingHere) ? (
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
                  {/* pb-40: room for the floating input, so the last message can scroll clear of it */}
                  <MessageScrollerContent className="mx-auto w-full max-w-3xl px-4 pt-6 pb-40">
                    {active.messages.map((m) => (
                      <MessageScrollerItem key={m.id} scrollAnchor={m.role === "user"}>
                        <ChatMessage message={m} />
                      </MessageScrollerItem>
                    ))}
                    {streamingHere && (
                      <MessageScrollerItem>
                        <ChatStatus events={pending.events} />
                      </MessageScrollerItem>
                    )}
                  </MessageScrollerContent>
                </MessageScrollerViewport>
                <MessageScrollerButton className="data-[direction=end]:bottom-32" />
              </MessageScroller>
            </MessageScrollerProvider>
          )}

          {/* right-3 leaves the scrollbar uncovered; the gradient fades messages out behind the input */}
          <div className="pointer-events-none absolute bottom-0 left-0 right-3 bg-linear-to-t from-background from-70% to-transparent pt-8">
            <form
              className="pointer-events-auto mx-auto flex w-full max-w-3xl gap-2 px-4 pb-10"
              onSubmit={(e) => {
                e.preventDefault();
                const q = question.trim();
                if (!q || pending) return;
                setQuestion("");
                send(q);
              }}
            >
              <Input
                value={question}
                onChange={(e) => setQuestion(e.target.value)}
                placeholder="How many tracks are in the database?"
                aria-label="Question"
                className="h-12 rounded-xl px-4 text-base md:text-base"
              />
              {streamingHere ? (
                <Button type="button" variant="secondary" onClick={stop} aria-label="Stop" className={SEND_BUTTON}>
                  <SquareIcon />
                </Button>
              ) : (
                <Button
                  type="submit"
                  disabled={!question.trim() || pending !== null}
                  aria-label="Send"
                  className={SEND_BUTTON}
                >
                  <ArrowUpIcon />
                </Button>
              )}
            </form>
          </div>
        </div>
      </SidebarInset>
    </SidebarProvider>
  );
}
