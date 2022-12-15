<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<!-- 세션 정보 변경 -->
<%
	session.setMaxInactiveInterval(1200); // default : 1800 (30분)
%>

<body>
	<h2> 세션 설정 확인 </h2>
	<ul>
		<li>세션 유지 시간 : <%= session.getMaxInactiveInterval() %></li>
		<li>세션 아이디 : <%= session.getId() %></li>
	</ul>
</body>
</html>