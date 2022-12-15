<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%
	String id = request.getParameter("user_id");
	String pwd = request.getParameter("user_pwd");

	
	if(id.equalsIgnoreCase("123") && pwd.equalsIgnoreCase("123")){
		// 단순 비교로 로그인에 성공했다면 response 메소드를 이용해 이동 ( 단순 페이지 이동 )
		response.sendRedirect("ResponseLoginSuccess.jsp");		
	}else{
		response.sendRedirect("Response.jsp");
	}
%>