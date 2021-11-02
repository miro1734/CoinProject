package org.coin;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;


@Component
public class ChatHandler extends TextWebSocketHandler{

	private static List<WebSocketSession> list = new ArrayList<>();
	@Override // 커넥션이 연결 됐을 때
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		list.add(session);
	}

	@Override // 소켓에 메시지를 보냈을 때
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		String payload = message.getPayload(); // 전송되는 데이터
		for(WebSocketSession wss: list) {
			wss.sendMessage(message);
		}
	}

	@Override // 커넥션이 클로즈 됐을 때
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		list.remove(session);
	}
	
}
