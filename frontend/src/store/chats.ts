import { create } from "zustand";
import * as chatsApi from "@/lib/chats";
import type { ChatDetail, ChatMessage, ChatSummary, StreamNodeEvent } from "@/lib/chats";
import { readSSE } from "@/lib/sse";

// only one reply streams at a time, so one controller is enough
let inFlight: AbortController | null = null;

const localMessage = (role: ChatMessage["role"], content: string, status: ChatMessage["status"]): ChatMessage => ({
  id: -Date.now(), // negative: never collides with a server id, replaced on the next reload
  role,
  content,
  sql: null,
  rows: null,
  status,
  attempts: null,
  events: null,
  created_at: new Date().toISOString(),
});

type ChatsState = {
  chats: ChatSummary[];
  active: ChatDetail | null;
  loading: boolean;
  error: string | null;
  // the reply being streamed right now, and which chat it belongs to; null when idle
  pending: { chatId: string; events: StreamNodeEvent[] } | null;
  loadChats: () => Promise<void>;
  openChat: (id: string) => Promise<void>;
  newChat: () => void;
  removeChat: (id: string) => Promise<void>;
  send: (question: string) => Promise<void>;
  stop: () => void;
};

export const useChatsStore = create<ChatsState>((set, get) => {
  // every action has the same failure path: show the message, stop the spinner
  const run = async (work: () => Promise<void>) => {
    set({ loading: true, error: null });
    try {
      await work();
    } catch (e) {
      set({ error: (e as Error).message });
    } finally {
      set({ loading: false });
    }
  };

  return {
    chats: [],
    active: null,
    loading: false,
    error: null,
    pending: null,

    loadChats: () => run(async () => set({ chats: await chatsApi.listChats() })),

    openChat: (id) => run(async () => set({ active: await chatsApi.getChat(id) })),

    // just a blank screen: the chat is only created on the server when its first
    // question is sent, so clicking New chat repeatedly can't pile up empty chats
    newChat: () => set({ active: null, error: null }),

    removeChat: (id) =>
      run(async () => {
        await chatsApi.deleteChat(id);
        set({
          chats: get().chats.filter((c) => c.id !== id),
          active: get().active?.id === id ? null : get().active,
        });
      }),

    send: async (question) => {
      if (get().pending) return;
      if (!get().active) {
        await run(async () => {
          const created = await chatsApi.createChat();
          set({ chats: [created, ...get().chats], active: { ...created, messages: [] } });
        });
      }
      const chat = get().active;
      if (!chat) return; // creating it failed; run() is already showing the error

      // show the question right away; the server's copy replaces it on reload below
      const withQuestion = [...chat.messages, localMessage("user", question, null)];
      set({ active: { ...chat, messages: withQuestion }, pending: { chatId: chat.id, events: [] }, error: null });

      const controller = new AbortController();
      inFlight = controller;
      try {
        const res = await fetch(`/api/chats/${chat.id}/messages/stream`, {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({ question }),
          signal: controller.signal,
        });
        await readSSE(res, (payload) => {
          if (payload === "[DONE]") return;
          const data = JSON.parse(payload);
          if (data.error) set({ error: data.error });
          else set({ pending: { chatId: chat.id, events: [...(get().pending?.events ?? []), data] } });
        });
      } catch (e) {
        if ((e as Error).name !== "AbortError") set({ error: (e as Error).message });
      } finally {
        inFlight = null;
      }

      // the user may have opened another chat while this one streamed; don't overwrite it
      const stillOpen = () => get().active?.id === chat.id;
      try {
        if (controller.signal.aborted) {
          // The server saves a "stopped" reply once it notices the disconnect, which can
          // land after a reload would run. Show it locally; reopening the chat shows the saved copy.
          const stopped = localMessage("assistant", "", "stopped");
          const chats = await chatsApi.listChats();
          set({ chats, ...(stillOpen() && { active: { ...chat, messages: [...withQuestion, stopped] } }) });
        } else {
          // the backend saved both messages and may have renamed the chat, so reload both
          const [detail, chats] = await Promise.all([chatsApi.getChat(chat.id), chatsApi.listChats()]);
          set({ chats, ...(stillOpen() && { active: detail }) });
        }
      } catch (e) {
        set({ error: (e as Error).message });
      } finally {
        set({ pending: null });
      }
    },

    stop: () => inFlight?.abort(),
  };
});
