package com.joinwork.util;

import java.util.Date;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.joinwork.emp.dto.EmpVO;

public class EchoHandler extends TextWebSocketHandler{
	
	// 로그인중인 개별유저
	private static Map<String, WebSocketSession> users = new ConcurrentHashMap<String, WebSocketSession>();
	
	
	// 클라이언트가 서버로 연결시
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		String senderId = getEmpId(session); // 접속한 유저의 http세션을 조회하여 id를 얻는 함수
		if(senderId!=null) {	// 로그인 값이 있는 경우만
			log(senderId + " 연결 됨");
			users.put(senderId, session);   // 로그인중 개별유저 저장
		}
	}
	
	// 클라이언트가 Data 전송 시
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
//		String senderEmail = getEmail(session);
		//모든 유저에게 보낸다 - 브로드 캐스팅
//		for (WebSocketSession sess : users.values()) {
//			sess.sendMessage(new TextMessage(senderNickname + ": " +  message.getPayload()));
//		}
		
		// 특정 유저에게 보내기
		String msg = message.getPayload();
		if(msg != null) {
			String[] strs = msg.split(",");
			if(strs != null) {
				if("[채팅]".equals(strs[0])) {	// 채팅
					String receiverId = strs[1];
					String receiverName = strs[2];
					String senderId = strs[3];
					String content = strs[4];
					WebSocketSession targetSession = users.get(receiverId);  // 메시지를 받을 세션 조회
					TextMessage tmpMsg = new TextMessage("[채팅],"+receiverId+","+receiverName+","+senderId+","+content);
					targetSession.sendMessage(tmpMsg);
				}else { // 알림
					String empReaderId = strs[0];
					String alarmTitle = strs[1];
					String alarmContent = strs[2];
					String alarmUrl = strs[3];
					String alarmCategory = strs[4];
					String contextPath = strs[5];
					WebSocketSession targetSession = users.get(empReaderId);  // 메시지를 받을 세션 조회
					
					// 실시간 접속시
					if(targetSession!=null) {
						TextMessage tmpMsg = new TextMessage(contextPath+","+empReaderId+","+alarmTitle+","+alarmContent+","+alarmUrl);
						targetSession.sendMessage(tmpMsg);
					}
				}
			}
		}
	}
	
	// 연결 해제될 때
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		String senderId = getEmpId(session);
		if(senderId!=null) {	// 로그인 값이 있는 경우만
			log(senderId + " 연결 종료됨");
			users.remove(senderId);
		}
	}
	
	// 에러 발생시
	@Override
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
		log(session.getId() + " 익셉션 발생: " + exception.getMessage());
	}
	
	// 로그 메시지
	private void log(String logmsg) {
		System.out.println(new Date() + " : " + logmsg);
	}
	
	// 웹소켓에 id 가져오기
    // 접속한 유저의 http세션을 조회하여 id를 얻는 함수
	private String getEmpId(WebSocketSession session) {
		Map<String, Object> httpSession = session.getAttributes();
		EmpVO loginUser = (EmpVO) httpSession.get("loginUser");
		
		return loginUser != null ? loginUser.getEmpId() : null;
	}
}
