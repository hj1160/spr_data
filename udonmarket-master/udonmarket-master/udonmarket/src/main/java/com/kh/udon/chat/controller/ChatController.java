package com.kh.udon.chat.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.kh.udon.chat.model.service.ChatService;
import com.kh.udon.chat.model.vo.ChatMessage;
import com.kh.udon.chat.model.vo.ChatRoom;
import com.kh.udon.common.util.Utils;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/chat")
@Slf4j
public class ChatController
{
	@Autowired
    private ChatService service;
    
    @RequestMapping("/chatListView")
    public Model chatList(@RequestParam("userId") String userId,
    					   Model model){
    	
    	List<ChatRoom> list = service.selectChatRoom(userId);
    	log.debug("list = {}", list);
    	model.addAttribute("list", list);
    	
        return model;
    }
    
    @PostMapping("/selectChatMsg")
    @ResponseBody
    public Map<String, Object> selectChatMsg(@RequestParam("roomCode") int roomCode){
    	Map<String, Object> map = new HashMap<>();
    	
    	List<ChatMessage> list = service.selectChatMsg(roomCode);
    	log.debug("list = {}", list);
    	
    	map.put("list", list);
    	return map;
    }
    
    @PostMapping("/openChatRoom")
    @ResponseBody
    public String openChatRoom(@RequestParam("userId") String userId,
							   @RequestParam("seller") String seller,
							   @RequestParam("pCode") int pCode){

    	Map<String, Object> map = new HashMap<>();
    	map.put("userId", userId);
    	map.put("seller", seller);
    	map.put("pCode", pCode);
    	
    	//?????? ???????????? ???????????? ????????? ??????
    	ChatRoom chatRoom = service.selectChatRoom(map);
    	
    	if(chatRoom == null) {
    		//????????? ????????? ?????????
    		int result = service.insertChatRoom(map);
    	}else {
    		//????????? ????????? ?????? true??? ????????? (?????? ????????? ?????? ????????????)
    		map.put("roomCode", chatRoom.getRoomCode());
    		
    		int enabled = service.enterChatRoom(map);
    	}
    	
    	return "/chat/chatListView?userId=" + userId;
    }

    @PostMapping("/leaveChatRoom")
    @ResponseBody
    public String leaveChatRoom(@RequestParam("roomCode") int roomCode,
    							@RequestParam("userId") String userId){
    	
    	Map<String, Object> map = new HashMap<>();
    	map.put("userId", userId);
    	map.put("roomCode", roomCode);
    	
    	String url = "/chat/chatListView?userId=" + userId;
    	try {
    		int result = service.leaveChatRoom(map);
    	}catch (Exception e) {
    		e.printStackTrace();
    	}

    	return url;

    }    
    
    @RequestMapping(value = "/sendPhoto",
    				method = RequestMethod.POST,
    				produces = "text/plain; charset=utf-8")
    @ResponseBody
    public String sendPhoto(MultipartFile file,
    						HttpServletRequest request){

    	String result = "";
    	
    	//?????? ????????? ?????? ???????????? (HttpServletRequest ?????????)
		String saveDirectory = request.getServletContext() //context-path (webapp)
									  .getRealPath("/resources/upload/chat");



		String fileName = file.getOriginalFilename();
		log.debug("fileName = {}", fileName);

		//????????? ??????
		String renamedFileName = Utils.getRenamedFileName(fileName);
		
		//???????????? ?????? -> ?????????????????? ????????? ??????
		File newFile = new File(saveDirectory, renamedFileName);
		try {
			file.transferTo(newFile);
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}			
		
		result = fileName + "/" + renamedFileName ;

    	return result;
    }       
    
}
