<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
	String popupMode = "on";

	Cookie[] cookies = request.getCookies();
	if(cookies != null){
		for(Cookie c : cookies){
			String cookieName = c.getName();
			String cookieValue = c.getValue();
			
			if(cookieName.equals("PopupClose")){
				popupMode = cookieValue;
			}
		}
	}

%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script type="text/javascript">
	$(function(){
		$("#closeBtn").click(function(){
			$("#popup").hide();
			var chkVal = $("input:checkbox[id=inactiveToday]:checked").val();
			
			$.ajax({
				url:'./PopupCookie.jsp',
				type:'get',
				data : {inactiveToday : chkVal},
				dataType : "text",
				success : function(resData){
					if(resData != '') 
						location.reload();
				}
				
			})
			
		});
	});
</script>

<style>
	div#popup {
		position: absolute;
		top: 100px;
		left: 100px;
		color: yellow;
		width: 300px;
		height: 100px;
		background-color: gray;
	}
	
	div#popup>div {
		position: relative;
		background-color: #ffffff;
		top: 0px;
		border: 1px solid gray;
		padding: 10px;
		color: black;
	}
</style>
</head>
<body>
	<h2>팝업 메인 페이지 </h2>
	<p> 현재 팝업 창은 <%=popupMode%> 입니다 </p>
	
<%
	if(popupMode.equals("on")){
%>
		<div id="popup">
			<h2 align="center"> 공지사항 팝업입니다. </h2>
			<div align="right"> 
				<form name="popFrm">
					<input type="checkbox" id="inactiveToday" value="1"/>
					하루동안 열지 않음
					<input type="button" value="닫기" id="closeBtn"/>
				</form>
			</div>
		</div>
<%
	}
%>
</body>
</html>