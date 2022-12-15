<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2> 쿠키값 확인 </h2>
	<% 
		Cookie[] cookie = request.getCookies();
	if(cookie != null){
		for(int i = 0 ; i < cookie.length ; i++){
			String cookieName = cookie[i].getName();
			String cookieValue = cookie[i].getValue();
			out.println(String.format("쿠키 명 : %s <br/> 쿠키 값 : %s" , cookieName , cookieValue));
		}
	}
	%>
</body>
</html>