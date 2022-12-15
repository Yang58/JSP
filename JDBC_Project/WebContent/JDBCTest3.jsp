<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="common.JDBConnect" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
	// web.xml에서 초기화한 값을 받아 사용하는 DB 연결 방식
	String driver = application.getInitParameter("OracleDriver");
	String url = application.getInitParameter("OracleUrl");
	String id = application.getInitParameter("OracleId");
	String pwd =application.getInitParameter("OraclePwd");
	
	JDBConnect jdbc = new JDBConnect(driver,url,id,pwd);
	out.print("<h1> DB 연결 성공 </h1>");
	jdbc.close();
%>

</body>
</html>