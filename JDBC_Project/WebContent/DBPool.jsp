<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="common.DBConnPool" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	DBConnPool connection = new DBConnPool();
	out.print("DB연결 성공");
	connection.close();
%>

</body>
</html>