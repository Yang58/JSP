<%@page import="common.JDBConnect"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	// 기본 생성자 호출을 통한 DB연결 
	JDBConnect jdbc = new JDBConnect(application);
	out.print("<h1> DB 연결 성공 </h1>");
	jdbc.close();
%>

</body>
</html>