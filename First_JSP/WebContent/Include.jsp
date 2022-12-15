<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<%-- 
			<%@ include file = "경로 정보 ( 상대 , 절대 ) "  %>  
			http://localhost:8081/First_JSP - 절대 경로 
			IncludeJSP.jsp - 상대 경로 
			
			3대 지시어 : page , include , taglib 
--%>
			
<%@ include file="IncludeJSP.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">

</script>
</head>
<body>

<%
 out.println("오늘 날짜 :" + today);
 out.println(" <br>" );
 out.println("내일 날짜 :" + tomorrow);
%>
</body>
</html>