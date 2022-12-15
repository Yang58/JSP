<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="common.Person"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>page 영역 2</title>
</head>
<body>
	<h2>page 영역2 의 속성값 읽기</h2>
<%
	Object pageInt = (pageContext.getAttribute("pageInteger"));
	Object pageStr = (pageContext.getAttribute("pageString"));
	Object pagePer = (pageContext.getAttribute("pagePerson"));
%>
<ul>
	<li><%=(pageInt == null) ? "값 없음 " : pageInt %></li>
	<li><%=(pageStr == null) ? "값 없음 " : pageStr %></li>
	<li><%=(pagePer == null) ? "값 없음 " : ((Person)pagePer).getName()%></li>
</ul>
</body>
</html>