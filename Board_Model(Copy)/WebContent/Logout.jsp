<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	session.removeAttribute("userId");
	session.removeAttribute("userName");
	
	session.invalidate(); 
	
	response.sendRedirect("LoginForm.jsp");

%>
