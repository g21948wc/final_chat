<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Chat</title>
    <script type="text/javascript">
        function startChat() {
            var socket = new WebSocket("ws://" + location.host + "<%= request.getContextPath() %>/chat");

            socket.onmessage = function (event) {
                var message = event.data;
                // メッセージを表示する処理を記述
            }

            document.getElementById("sendButton").onclick = function () {
                var message = document.getElementById("messageInput").value;
                socket.send(message);
                document.getElementById("messageInput").value = "";
            };
        }
    </script>
</head>
<body onload="startChat()">
    <h1>Chat</h1>
    <div id="chatArea"></div>
    <input type="text" id="messageInput" />
    <button id="sendButton">Send</button>
</body>
</html>