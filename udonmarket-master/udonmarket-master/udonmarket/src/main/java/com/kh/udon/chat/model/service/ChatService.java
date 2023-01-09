package com.kh.udon.chat.model.service;

import java.util.List;
import java.util.Map;

import com.kh.udon.chat.model.vo.ChatMessage;
import com.kh.udon.chat.model.vo.ChatRoom;

public interface ChatService
{

	List<ChatRoom> selectChatRoom(String userId);

	List<ChatMessage> selectChatMsg(int roomCode);

	int insertMsg(ChatMessage m);

	ChatRoom selectChatRoom(Map<String, Object> map);

	int insertChatRoom(Map<String, Object> map);

	int leaveChatRoom(Map<String, Object> map);

	int enterChatRoom(Map<String, Object> map);

}
