<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="common.Person" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<h1> REQUEST 영역 </h1>
<%
	String requestString = (String)(request.getAttribute("reString"));
	Person person = (Person)(request.getAttribute("rePerson"));
%>
<%=requestString %> <br>
<%=person.getName()%>
<%=person.getAge()%>



</body>
</html>