import { create } from "zustand";
import * as chatsApi from "@/lib/chats";
import type { ChatDetail, ChatSummary } from "@/lib/chats";

type ChatsState = {
  chats: ChatSummary[];
  active: ChatDetail | null;
  loading: boolean;
  error: string | null;
  loadChats: () => Promise<void>;
  openChat: (id: string) => Promise<void>;
  newChat: () => Promise<void>;
  removeChat: (id: string) => Promise<void>;
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

    loadChats: () => run(async () => set({ chats: await chatsApi.listChats() })),

    openChat: (id) => run(async () => set({ active: await chatsApi.getChat(id) })),

    newChat: () =>
      run(async () => {
        const chat = await chatsApi.createChat();
        set({ chats: [chat, ...get().chats], active: { ...chat, messages: [] } });
      }),

    removeChat: (id) =>
      run(async () => {
        await chatsApi.deleteChat(id);
        set({
          chats: get().chats.filter((c) => c.id !== id),
          active: get().active?.id === id ? null : get().active,
        });
      }),
  };
});
