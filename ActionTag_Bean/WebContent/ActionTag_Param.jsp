<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:forward page="ParamForward.jsp?param=0">
		<jsp:param value="1" name="param1"/>
		<jsp:param value="2" name="param2"/>
		<jsp:param value="3" name="param3"/>
	</jsp:forward>
	
	
</body>
</html>