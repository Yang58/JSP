<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h3> 액션 태그로 폼값 한번에 받기 </h3>
	<jsp:useBean id="person" class="common.Person"></jsp:useBean>
	<jsp:setProperty property="*" name="person"/>
	<ul>
		<li>이름 : <jsp:getProperty name="person" property="name"></jsp:getProperty></li>
		<li>나이 : <jsp:getProperty name="person" property="age"></jsp:getProperty></li>
	</ul>
</body>
</html>