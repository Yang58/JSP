<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="com.google.gson.Gson" %>
<%@ page import="member.Member" %>
    
<%
	request.setCharacterEncoding("UTF-8");
	
	String id = request.getParameter("userid");
	String pw = request.getParameter("userPw");
	
	String uid = "admin";
	
	Member m ;
	if(uid.equals(id)){
		m = new Member(id,pw);
	}else{
		m = new Member();
	}

	Gson gson = new Gson();
	
	out.print(gson.toJson(m));
%>