<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>웹 소켓 채팅</title>
<script type="text/javascript">
	var webSocket = new WebSocket("ws://localhost:8081/Chatting_Project/ChatingServer");
	var chatWindow, chatMessage , chatId;
	
	// 채팅창이 열리면 대화창 , 메시지 입력창 , 대화명 표시한으로 사용할 DOM객체 저장 
	window.onload = function(){
		chatWindow = document.getElementById("chatWindow");
		chatMessage = document.getElementById("chatMessage");
		chatId = document.getElementById('chatId').value;
	}
	
	function sendMessage(){
		// 대화창 표시
		chatWindow.innerHTML += "<div class='myMsg'>" + chatMessage.value + "</div>"  
		webSocket.send(chatId + '|' + chatMessage.value); // 서버로 전송
		chatMessage.value=""; // 메시지 입력창 지우기 
		chatWindow.scrollTop = chatWindow.scrollHeight; // 대화창 스크롤  
	}
	// 서버와 연결 종료 
	function disconnect()	{
		webSocket.close();
	}
	
	// 엔터 키 입력 처리 
	function enterKey(){
		if(window.event.keyCode == 13){
			sendMessage();
		}
	}
	webSocket.onopen = function(event){
		chatWindow.innerHTML += "웹 소켓 서버에 연결 되었습니다. <br/>";
	};
	webSocket.onclose = function (event){
		chatWindow.innerHTML += "웹 소켓 서버가 종료되었습니다. <br/>";
	};
	webSocket.onerror = function(event) {
		alert(event.data);
		chatWindow.innerHTML += "채팅 중 에러가 발생했습니다. <br/>";
	};
	webSocket.onmessage = function(event){
		var message = event.data.split("|"); // split('문자')를 이용해 배열 형태로 데이터 저장  
		var sender = message[0]; 
		var content = message[1];
		if(content != ""){
			if (content.match("/")){
				if(content.match(("/" + chatId))){
					var temp = content.replace(("/" + chatId) , "[귓속말] : ");
					chatWindow.innerHTML += "<div>" + sender + "" + temp + "</div>";
				}
			}else{
				chatWindow.innerHTML += "<div>" + sender + " : " + content + "</div>";
			}
		}
		chatWindow.scrollTop = chatWindow.scrollHeight;
	};
</script>
<style>
#chatWindow{border:1px solid black ; width:270px ; height: 310px ; overflow:scroll; padding:5px;}
#chatMessage{width:246px ; height:30px;}
#sendBtn{height:30px; position:relative; top:2px;left:-2px;}
#closeBtn{margin-bottom:3px; position:relative; top : 2px ; left:-2px;}
#chatId{width:158px; height:24; border:1px solid #AAAAAA; background-color:#EEEEEE;}
.myMsg{text-align:right;}
</style>
</head>
<body>
  대화명 : <input type="text" id="chatId" value="${param.chatId }" readonly />
  <button id ="closeBtn" onclick="disconnect();" > 채팅 종료 </button>
  <div id="chatWindow"></div>
  <div> 
  	 <input type="text" id="chatMessage" onkeyup="enterKey()"/>
  	 <button id="sendBtn" onclick="sendMessage();"> 전송 </button>
  </div>
</body>
</html>