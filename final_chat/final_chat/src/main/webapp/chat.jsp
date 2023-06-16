<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Chat</title>
    <script type="text/javascript">
        var messageLog = []; // メッセージログを保持する配列

        function startChat() {
            var socket = new WebSocket("ws://" + location.host + "<%= request.getContextPath() %>/chat");

            socket.onmessage = function (event) {
                var message = event.data;
                appendMessage(message); // 新しいメッセージを表示する関数を呼び出す
                addToLog(message); // メッセージをログに追加する関数を呼び出す
            }

            document.getElementById("sendButton").onclick = function () {
                var message = document.getElementById("messageInput").value;
                socket.send(message);
                document.getElementById("messageInput").value = "";
            };

            // ページが読み込まれた時にログを表示する
            displayLog();
        }

        function appendMessage(message) {
            var chatArea = document.getElementById("chatArea");
            var messageElement = document.createElement("p");
            messageElement.innerHTML = message;
            chatArea.appendChild(messageElement);
        }

        function addToLog(message) {
            messageLog.push(message);
        }

        function displayLog() {
            var logArea = document.getElementById("logArea");
            logArea.innerHTML = messageLog.join("<br>");
        }
    </script>
</head>
<body onload="startChat()">
    <h1>Chat</h1>
    <div id="chatArea"></div>
    <input type="text" id="messageInput" />
    <button id="sendButton">Send</button>
    <h2>Message Log</h2>
    <div id="logArea"></div>
</body>
</html>