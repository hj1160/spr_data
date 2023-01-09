package com.kh.udon.chat.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.udon.chat.model.vo.ChatMessage;
import com.kh.udon.chat.model.vo.ChatRoom;

@Repository
public class ChatDaoImpl implements ChatDao
{
    @Autowired
    private SqlSessionTemplate session;

	@Override
	public List<ChatRoom> selectChatRoom(String userId) {
		return session.selectList("socket.selectChatRoom", userId);
	}

	@Override
	public List<ChatMessage> selectChatMsg(int roomCode) {
		return session.selectList("socket.selectChatMsg", roomCode);
	}

	@Override
	public int insertMsg(ChatMessage m) {
		return session.insert("socket.insertMsg", m);
	}

	@Override
	public ChatRoom selectChatRoom(Map<String, Object> map) {
		return session.selectOne("socket.selectChatRoomOne", map);
	}

	@Override
	public int insertChatRoom(Map<String, Object> map) {
		session.insert("socket.insertChatRoom", map);
		return Integer.valueOf(String.valueOf(map.get("roomCode")));
	}

	@Override
	public int insertChatUser(Map<String, Object> map) {
		return session.insert("socket.insertChatUser", map);
	}

	@Override
	public int insertChatSeller(Map<String, Object> map) {
		return session.insert("socket.insertChatSeller", map);
	}

	@Override
	public int leaveChatRoom(Map<String, Object> map) {
		return session.update("socket.leaveChatRoom", map);
	}

	@Override
	public int enterChatRoom(Map<String, Object> map) {
		return session.update("socket.enterChatRoom", map);
	}
}
