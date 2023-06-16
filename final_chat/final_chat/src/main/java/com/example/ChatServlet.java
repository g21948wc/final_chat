package com.example;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.websocket.server.ServerContainer;
import javax.websocket.server.ServerEndpointConfig;

@WebServlet("/chat")
public class ChatServlet extends HttpServlet {
    @Override
    public void init() throws ServletException {
        super.init();

        // WebSocketのエンドポイントを登録
        ServerContainer container = (ServerContainer) getServletContext().getAttribute(ServerContainer.class.getName());
        try {
            container.addEndpoint(ServerEndpointConfig.Builder.create(ChatWebSocket.class, "/chat").build());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/chat.jsp").forward(req, resp);
    }
}