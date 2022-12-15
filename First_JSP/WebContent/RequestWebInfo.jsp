<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.util.Enumeration" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<%
	request.setCharacterEncoding("UTF-8"); // post방식으로 데이터를 넘길떄 한글이 깨질수도있음 
	String value1 = request.getParameter("eng");
	String value2 = request.getParameter("han");
%>

<script type="text/javascript">
	console.log('eng :<%=value1%>');
	console.log("han :<%=value2%>");
</script>
<body>
	<h2>1. 클라이언트와 서버의 환경 정보 읽기</h2>
	<ul>
		<li>데이터 전송 방식 : <%= request.getMethod() %></li>
		<li> URL : <%= request.getRequestURL() %></li>
		<li> URI : <%= request.getRequestURI() %></li>
		<li> Path : <%= request.getRealPath("") %></li>  <!-- Tomcat이 실제 파일을 관리하는곳의 경로  -->
		<li> 프로토콜 : <%= request.getProtocol() %></li>
		<li> 서버명 : <%= request.getServerName() %></li>
		<li> 서버 포트 : <%= request.getServerPort() %></li>
		<li> 클라이언트 IP주소 <%= request.getRemoteAddr() %></li>
		<li> 쿼리스트링 : <%= request.getQueryString() %></li>
		<li> 전송된 값 1 : <%=request.getParameter("eng") %></li>
		<li> 전송된 값 2 : <%=request.getParameter("han") %></li>
		
		
	</ul>

</body>
</html>