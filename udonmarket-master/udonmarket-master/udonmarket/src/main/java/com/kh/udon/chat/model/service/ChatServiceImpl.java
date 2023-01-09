package com.kh.udon.chat.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.udon.chat.model.dao.ChatDao;
import com.kh.udon.chat.model.vo.ChatMessage;
import com.kh.udon.chat.model.vo.ChatRoom;

@Service
public class ChatServiceImpl implements ChatService
{
    @Autowired
    private ChatDao dao;

	@Override
	public List<ChatRoom> selectChatRoom(String userId) {
		return dao.selectChatRoom(userId);
	}

	@Override
	public List<ChatMessage> selectChatMsg(int roomCode) {
		return dao.selectChatMsg(roomCode);
	}

	@Override
	public int insertMsg(ChatMessage m) {
		return dao.insertMsg(m);
	}

	@Override
	public ChatRoom selectChatRoom(Map<String, Object> map) {
		return dao.selectChatRoom(map);
	}

	@Transactional(rollbackFor = { Exception.class })
	@Override
	public int insertChatRoom(Map<String, Object> map) {
		int result = 0;
		
		//채팅방 열기
		//roomCode 리턴
		result = dao.insertChatRoom(map);
		System.out.println("roomCode = " + result);
		
		if(result > 0) { 
			//참여인원 넣기 
			map.put("roomCode", result); 
			//구매자 userId 넣기
			result = dao.insertChatUser(map); 
			//seller 넣기 
			result = dao.insertChatSeller(map);
		}else { 
			// throw new ChatException("채팅방 생성 오류!");
		 }

		return result;
	}

	@Override
	public int leaveChatRoom(Map<String, Object> map) {
		return dao.leaveChatRoom(map);
	}

	@Override
	public int enterChatRoom(Map<String, Object> map) {
		return dao.enterChatRoom(map);
	}


}
