<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
	// 비동기 처리 
	$(function(){
		$("#check").click(function(){
			if($("#userId").val() == ""){
				$("#result").text("아이디를 입력해주세요");
				return;
			}
		})
		
		query = {
				userId : $("#userId").val(),
				userPw : $("#userPw").val()
		}
		$.ajax({
			url : 'ajaxServer.jsp', 
			type : 'post',
			data : query
			
		}).done(function(data){
			// 정상적으로 서버가 동작되고 데이터가 제대로 넘어왔다면 실행되는 메서드 
			//Gson을 통해 변환된 데이터는 문자열 형태로 반환됨 객체로 사용하기위해 변환 과정을 한번 거쳐줘야함 
			obj = JSON.parse(data);
			if( obj.userId != undefined ){
				$("#result").text(obj.userId + " / " +obj.userPw);
			}else{
				$("result").text("존재하지 않는 아이디 입니다.")
			}
		}); 
			
		
	});
</script>
</head>
<body>
	<label>ID</label>
	<input type="text" id="userId">
	<label>PW</label>
	<input type="text" id="userPw">
	<button id="check">Check</button>
	<p id="result"> </p>
</body>
</html>