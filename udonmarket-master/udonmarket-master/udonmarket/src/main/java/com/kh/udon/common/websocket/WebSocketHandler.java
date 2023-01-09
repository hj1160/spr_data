package com.kh.udon.common.websocket;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.kh.udon.chat.model.service.ChatService;
import com.kh.udon.chat.model.vo.ChatMessage;
import com.kh.udon.member.model.service.MemberService;
import com.kh.udon.member.model.vo.Member;
import com.kh.udon.member.model.vo.Noti;

import lombok.extern.slf4j.Slf4j;

/**
 * 1. 텍스트 메세지 전용
 * 	  TextWebSocketHandler - handlerTextMessage
 * 2. 바이너리 메세지 전용
 * 	  BinaryWebSocketHandler - handleBinaryMessage
 *
 * 웹소켓 연결 시작하기 (jsp)
 * var webSocket = new WebSocket("ws://요청주소");
 * var sock = new SockJS("http://요청주소");
 *
 * 온라인 상태 일 경우에만 알림 보내기
 * 1. WS 연결은 전역에서 한다 (footer.jsp) - 어느 페이지에 있던 알림 받을 수 있도록
 * 2. Server에서는 로그인 사용자의 id 별 SocketSession 관리가 필요하다
 * 3. 댓글 작성 or 키워드 관련 상품 업데이트 or ... 면 Websocket에 알린다
 *
 */
@Slf4j
public class WebSocketHandler extends TextWebSocketHandler{
	
	@Autowired
	private MemberService service;

	@Autowired
	private ChatService chatService;
	
	//세션 리스트 (현재 login 중인 정보를 모두 모아 놓는 곳)
	private List<WebSocketSession> sessions = new ArrayList<WebSocketSession>();
	
	//1대1
	private Map<String, WebSocketSession> userSessions = new HashMap<>(); 

	//웹소켓이 연결되면 호출되는 함수
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		sessions.add(session);
		String senderId = getId(session);
		userSessions.put(senderId, session); //Map에 senderId 키값으로 session 담기
		log.debug("연결 되었습니다 : {} ", senderId);
	}		

	//클라이언트가 서버로 메세지를 전송했을 때 실행 되는 메소드
	// WebSocketSession session : 전송 주체 정보가 담긴 세션
    // TextMessage message : 전송 받은 메세지 정보
	@Override
	protected void handleTextMessage(WebSocketSession session, 
									 TextMessage message) throws Exception {
		
		String senderId = getId(session);
		log.debug("{} : {} ", senderId, message);
		
		//protocol 
		//cmd(구분자), 발신자, 수신자, 게시글번호, 게시글제목, 기타 내용  : (reply, user1, writer, 1234, 안녕하세요, 공지사항)
		String msg = message.getPayload();
		
		//메세지가 있을 경우에만
		if(StringUtils.isNotEmpty(msg)) {
			String[] strs = msg.split(",");
			
			/**
			 * noti
			 */
			if(strs != null && strs.length == 6) {
				String cmd = strs[0];
				String sender = strs[1];
				String receiver = strs[2];
				int pCode = Integer.parseInt(strs[3]);
				String title = strs[4];
				String noti = strs[5];
				
				Noti n = new Noti(0, cmd, sender, receiver, pCode, title, noti, false, null);
				
				//현재 접속 중인 (로그인 중인) 사용자 중에 receiver가 있을때만 알림을 보낸다
				WebSocketSession receiverSession = userSessions.get(receiver); 
				
				if("price".equals(cmd) && receiverSession != null) {
//					TextMessage tmpMsg = new TextMessage("[가격 변동] " + boardNo +"의 가격이 " + noti + " 원으로 변동 되었습니다.");
					TextMessage tmpMsg = new TextMessage("[가격 변동] " 
							+ "<a href='/udon/product/productDetailView?pCode=" + pCode + "'>" + title +"</a>의 가격이 " + noti + " 원으로 변동 되었어요.");
	
					receiverSession.sendMessage(tmpMsg);									
				}
				else if("keyword".equals(cmd) && receiverSession != null) {
					TextMessage tmpMsg = new TextMessage("[키워드:" + noti + "] '" + title + "' 이 올라왔어요.");
					
				//	TextMessage tmpMsg = new TextMessage("[키워드 : " + noti + "] " 
				//			+ "<a href='/udon/product/productDetailView?pCode=" + pCode + "'>" + title +"</a>의 가격이 " + noti + " 원으로 변동 되었어요.");
					receiverSession.sendMessage(tmpMsg);
				}
				else if("reply".equals(cmd) && receiverSession != null) {
//					TextMessage tmpMsg = new TextMessage("[댓글] " + sender + "님이" + pCode +"에 댓글을 달았습니다");
					TextMessage tmpMsg = new TextMessage("[댓글] 게시글 "
							+ "<a href='/udon/community/communityDetailView?bCode=" + pCode + "'>" + title +"에 댓글이 달렸어요.");

					receiverSession.sendMessage(tmpMsg);
				}
				else if("nego".equals(cmd) && receiverSession != null) {
					TextMessage tmpMsg = new TextMessage("[가격 제안] "
							+ "<a href='/udon/community/communityDetailView?bCode=" + pCode + "'>" + title +" 을/를 '" + noti +" 원' 으로 거래하고 싶어해요.");
					
					receiverSession.sendMessage(tmpMsg);
				}
				else if("like".equals(cmd) && receiverSession != null) {
					TextMessage tmpMsg = new TextMessage("[좋아요] 이웃이 "
							+ "<a href='/udon/community/communityDetailView?bCode=" + pCode + "'>" + title +" 을/를 ' 좋아합니다 ♡");
					
					receiverSession.sendMessage(tmpMsg);
				}
			
				log.debug("noti = {}", n);
				try {
					int result = service.insertNoti(n);
					log.debug("InsertNoti result = {}", result);
				}catch (Exception e) {
					e.printStackTrace();
				}			
			}
			
			/**
			 * chat
			 */
			if(strs != null && strs.length == 5) {
				String cmd = strs[0];
				String sender = strs[1];
				String receiver = strs[2];
				int roomCode = Integer.parseInt(strs[3]);
				String content = strs[4];
				
				String renamedFileName = null;
				
				String[] fileArr = content.split("/");
				
				ChatMessage m = new ChatMessage(0, roomCode, sender, content, null, null, renamedFileName, null);
				
				if(fileArr != null && fileArr.length == 2) {					
					m.setOriginalFileName(fileArr[0]);
					m.setRenamedFileName(fileArr[1]);
				}
				
				System.out.println("cmd = " + cmd);
				log.debug("sender = {}", sender);
				log.debug("receiver = {}", receiver);
				
				//현재 접속 중인 (로그인 중인) 사용자 중에 receiver가 있을때만 알림을 보낸다
				//사용자가 해당 채팅방에 있을 때만 알림을 보내기.............
				WebSocketSession receiverSession = userSessions.get(receiver); 
				
				Date now = new Date();
				SimpleDateFormat fmt = new SimpleDateFormat ("yyyy/MM/dd HH:mm");
				//fmt.format(now);


				if("chat".equals(cmd) && receiverSession != null) {
						
					String sendMsg = roomCode + 
							"@<div name='sendMsg' class='media w-50 mb-3'>" +
								"<div class='media-body ml-3' name='sender_" + sender + "'>" +
									"<div class='bg-light rounded py-2 px-3 mb-2'>" +
										"<p class='text-small mb-0 text-muted'>" + content + "</p>" +
									"</div>" +
									"<p class='small text-muted'>" + fmt.format(now) + "</p>" +
								"</div>" +
							"</div>";
					
					TextMessage tmpMsg = new TextMessage(sendMsg);
					receiverSession.sendMessage(tmpMsg);
				}
				
				else if("file".equals(cmd) && receiverSession != null) {
					
					String sendMsg = roomCode + 
							"@<div name='sendMsg' class='media w-50 mb-3'>" +
								"<div class='media-body ml-3' name='sender_" + sender + "'>" +
									"<div class='bg-light rounded py-2 px-3 mb-2'>" +
									"<img src='/udon/resources/upload/chat/" + fileArr[1] +"' width='150'>" +
									"</div>" +
									"<p class='small text-muted'>" + fmt.format(now) + "</p>" +
								"</div>" +
							"</div>";
					
					TextMessage tmpMsg = new TextMessage(sendMsg);
					receiverSession.sendMessage(tmpMsg);
					
				}
				
				//insert Chat
				log.debug("m = {}", m);
				try {
					int result = chatService.insertMsg(m);
					log.debug("InsertMsg result = {}", result);
				}catch (Exception e) {
					e.printStackTrace();
				}
				
			}
		}		
	}
	
	//클라이언트와의 연결을 끊었을 때 실행되는 메소드
	// 웹소켓이 연결이 종료 = 세션 종료
	@Override
	public void afterConnectionClosed(WebSocketSession session, 
									  CloseStatus status) throws Exception {
		
		String senderId = getId(session);
		log.debug("연결 해제 되었습니다 : {} ", senderId);
	}
	
	
	//session에 저장된 userId 가져오기
	private String getId(WebSocketSession session) {
		//Map객체에 session에 담긴 값들을 가져오기
		Map<String, Object> httpSession = session.getAttributes();
		//login할때 세션에 담았던 사용자 정보 가져오기
//		Member loginMember = (Member)httpSession.get("loginMember");

		 Member loginMember = (Member) ((Authentication) session
	                	 	   .getPrincipal()).getPrincipal();
		
		//로그인 하지 않은 사용자라면 sessionId 리턴
		if(loginMember == null)
			return session.getId();
		//로그인 한 사용자라면 UserId 리턴
		else 
			return loginMember.getUserId();
	}
		
}
