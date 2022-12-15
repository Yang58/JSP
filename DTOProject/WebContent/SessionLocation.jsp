<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<%
	ArrayList<String> lists = (ArrayList<String>)session.getAttribute("lists");
	for(String s : lists){
		out.print(s +" ");
	}
%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<a href="SessionLocation2.jsp"> SessionLocation2.jsp 페이지 이동 </a>

</body>
</html>