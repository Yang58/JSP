<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %> <!-- -->
<%
	// 기본 연결 방식 (DB 연결 테스트 용도로 사용 )
	Connection conn = null;
	try{
		String url = "jdbc:oracle:thin:@localhost:1521:orcl"; 
		Class.forName("oracle.jdbc.driver.OracleDriver"); // 지정 경로에 Class가 있는지 확인 
		conn = DriverManager.getConnection(url, "musthave" , "1234");// (DB 주소 , DB계정  , DB비빌번호)
		
		conn.close(); // 서버의 리소스 낭비를 방지하기위해 반드시 연결읠 해제 해야함 
	}catch(Exception e){
		e.printStackTrace();
	}
	out.print(conn +"<br/>") ;
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	DB연결 성공

</body>
</html>