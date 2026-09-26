"use client";

import { PlusIcon, Trash2Icon } from "lucide-react";
import {
  Sidebar,
  SidebarContent,
  SidebarGroup,
  SidebarGroupContent,
  SidebarGroupLabel,
  SidebarHeader,
  SidebarMenu,
  SidebarMenuAction,
  SidebarMenuButton,
  SidebarMenuItem,
} from "@/components/ui/sidebar";
import { Button } from "@/components/ui/button";
import { useChatsStore } from "@/store/chats";

export function ChatSidebar() {
  const { chats, active, loading, openChat, newChat, removeChat } = useChatsStore();

  return (
    <Sidebar>
      <SidebarHeader>
        <Button variant="outline" onClick={newChat} disabled={loading}>
          <PlusIcon />
          New chat
        </Button>
      </SidebarHeader>
      <SidebarContent>
        <SidebarGroup>
          <SidebarGroupLabel>Chats</SidebarGroupLabel>
          <SidebarGroupContent>
            <SidebarMenu>
              {chats.length === 0 && (
                <p className="px-2 text-xs text-muted-foreground">No chats yet.</p>
              )}
              {chats.map((chat) => (
                <SidebarMenuItem key={chat.id}>
                  <SidebarMenuButton isActive={chat.id === active?.id} onClick={() => openChat(chat.id)}>
                    <span className="truncate">{chat.title}</span>
                  </SidebarMenuButton>
                  <SidebarMenuAction showOnHover aria-label="Delete chat" onClick={() => removeChat(chat.id)}>
                    <Trash2Icon />
                  </SidebarMenuAction>
                </SidebarMenuItem>
              ))}
            </SidebarMenu>
          </SidebarGroupContent>
        </SidebarGroup>
      </SidebarContent>
    </Sidebar>
  );
}
