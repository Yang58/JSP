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
	String param = request.getParameter("param");
	String param1 = request.getParameter("param1");
	String param2 = request.getParameter("param2");
	String param3 = request.getParameter("param3");
	
	out.print(String.format("%s %s %s %s" , param, param1 ,param2 ,param3));
%>

<jsp:include page="paramInclude.jsp">
	<jsp:param value="INCLUDE1" name="name1"/>
	<jsp:param value="INCLUDE2" name="name2"/>
</jsp:include>	

</body>
</html>