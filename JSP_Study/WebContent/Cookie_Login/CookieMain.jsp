<%@page import="login_src.CookieManager"%>
<%@page import="login_src.AlertManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
	// 쿠키 읽어오기 
	String id = CookieManager.readCookie(request, "LoginID");
	
	String checked = "";
	if(!id.equals("")){
		checked = "checked";
	}
%>
<body>
	<h2> 로그인 페이지 </h2>
	<form action="makeCookie.jsp" method="post">
		아이디 : <input type="text" name="user_id" value="<%=id %>"  /> <input
			type="checkbox" name="save_check" value="Y"  <%=checked %>  /> 아이디
		저장하기 <br> 패스워드 : <input type="text" name="user_pw"/> <br> <input
			type="submit" value="로그인하기" />
	</form>
</body>
</html>