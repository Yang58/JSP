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
	pageContext.setAttribute("pAttr", "PAGE");
	request.setAttribute("rAttr", "REQUEST");
%>
	<h2> 액션 태그를 이용한 포워딩 </h2>
	<jsp:forward page="ForwardSub.jsp"></jsp:forward>
</body>
</html>