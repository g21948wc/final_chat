<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <title>Line Talk</title>
  <style>
    /* スタイルの定義 */
    body {
      background-color: #f2f2f2;
      font-family: Arial, sans-serif;
    }
    .container {
      max-width: 600px;
      margin: 0 auto;
      padding: 20px;
      background-color: #fff;
      border: 1px solid #ccc;
      border-radius: 5px;
      box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    }
    .message {
      margin-bottom: 10px;
      padding: 10px;
      border-radius: 5px;
      display: flex;
    }
    .sender {
      background-color: #dff0d8;
      justify-content: flex-end;
    }
    .receiver {
      background-color: #d9edf7; /* 青 */
      justify-content: flex-start;
    }
    .sender .message-content {
      color: #3c763d;
    }
    .receiver .message-content {
      color: #31708f;
    }
    .photo {
      width: 50px;
      height: 50px;
      border-radius: 50%;
      overflow: hidden;
      margin-right: 10px;
    }
    .photo img {
      width: 100%;
      height: 100%;
      object-fit: cover;
    }
  </style>
  <title>Chat</title>
  <script type="text/javascript">
    var messageLog = []; // メッセージログを保持する配列

    function startChat() {
      var socket = new WebSocket("ws://" + location.host + "<%= request.getContextPath() %>/chat");

      socket.onmessage = function(event) {
        var message = event.data;
        appendMessage(message); // 新しいメッセージを表示する関数を呼び出す
        addToLog(message); // メッセージをログに追加する関数を呼び出す
      };

      document.getElementById("sendButton").onclick = function() {
        var message = document.getElementById("messageInput").value;
        socket.send(message);
        document.getElementById("messageInput").value = "";
      };

      // ページが読み込まれた時にログを表示する
      displayLog();
    }

    function appendMessage(message, isSender) {
      var messageArea = document.getElementById("messageArea");
      var messageElement = document.createElement("div");
      messageElement.classList.add("message");
      if (isSender) {
        messageElement.classList.add("sender");
      } else {
        messageElement.classList.add("receiver");
      }
      var iconContainer = document.createElement("div");
      iconContainer.classList.add("photo");
      var iconImage = document.createElement("img");
      iconImage.src = "icon.png"; // アイコン画像のパスを設定する
      iconContainer.appendChild(iconImage);
      var messageContent = document.createElement("span");
      messageContent.classList.add("message-content");
      messageContent.innerText = message;
      messageElement.appendChild(iconContainer);
      messageElement.appendChild(messageContent);
      messageArea.appendChild(messageElement);
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
  <div class="container">
    
    <h2>Message Log</h2>
    <div id="logArea"></div>

    <div id="messageArea"></div>
     <h1>Chat</h1>
    <input type="text" id="messageInput" />
    <button id="sendButton">Send</button>
  </div>
</body>
</html>

