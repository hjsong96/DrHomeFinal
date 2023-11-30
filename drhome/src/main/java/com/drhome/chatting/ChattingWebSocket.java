package com.drhome.chatting;

import java.io.IOException;
import java.util.Collections;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

@Service
@ServerEndpoint(value = "/chatting/{roomNum}")
public class ChattingWebSocket {
	
    private static Set<Session> clients = Collections.synchronizedSet(new HashSet<Session>());
    //mno 넘겨서 roomNum다르게 해서 방따로 넣기
    
    @OnOpen
    public void onOpen(Session session, @PathParam("roomNum") String roomNum) {
        System.out.println("세션 오픈: " + session.getId() + " 방 번호: " + roomNum);
        session.getUserProperties().put("roomNum", roomNum);
        if (!clients.contains(session)) {
            clients.add(session); 
            System.out.println("세션 오픈: " + session);
        } else {
            System.out.println("이미 연결된 세션입니다!");
        }
    }

    @OnMessage
    public void onMessage(String msg, Session session) throws IOException {
        System.out.println("메시지 수신: " + msg);
        String roomNum = (String) session.getUserProperties().get("roomNum");

        for (Session s : clients) {
            String clientRoomNum = (String) s.getUserProperties().get("roomNum");

            if (roomNum.equals(clientRoomNum)) {
                System.out.println("데이터 전송: " + msg);
                s.getBasicRemote().sendText(msg);
            }
        }
    }

    @OnClose
    public void onClose(Session session, @PathParam("roomNum") String roomNum) {
        System.out.println("세션 종료: " + session.getId() + " 방 번호: " + roomNum);
        clients.remove(session);
    }
}
