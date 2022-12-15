<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.*" %>
<%@ page import="common.Person" %>


<%
	Map<String,Person> maps = (Map<String,Person>)application.getAttribute("maps");
	Set<String> set = maps.keySet();
	
	for(String s : set){
		Person p = maps.get(s);
		out.print( p.getName() + " ");
		out.print( p.getAge() + " ");
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>