<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.ArrayList" %>
<%

	ArrayList<String> lists = new ArrayList<>();
	lists.add("111");
	lists.add("222");
	session.setAttribute("lists",lists);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<a href="SessionLocation.jsp"> SessionLocation.jsp 페이지 이동 </a>
</body>
</html>