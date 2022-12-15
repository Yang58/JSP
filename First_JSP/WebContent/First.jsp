<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
	<!-- 자바 라이브러리 import -->
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%> 


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<% 
	// 자바 코드 ( 스크립틀릿 )
	Date today = new Date();
	int year = today.getYear();
	int day = today.getDay();
	int hour = today.getHours();
	out.println(year +"/"+ day +"/"+ hour);
	
	SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
	out.println(sf.format(today));
%>

	<h2>JSP</h2>
	<p>JSP</p>


</body>
</html>