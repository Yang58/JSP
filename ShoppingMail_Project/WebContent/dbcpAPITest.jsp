<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %>
    <%@ page import="javax.sql.*" %>
    <%@ page import="javax.naming.*" %>
<%
	Connection conn = null;
	
	try{
		Context init = new InitialContext();
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/myoracle");
		conn = ds.getConnection();
		
		out.print("연결 성공");
		
	}catch(Exception e){
		out.print("연결 실패");
		e.printStackTrace();
	}

%>