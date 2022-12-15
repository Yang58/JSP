<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		pageContext.setAttribute("ScopeValue", "페이지 영역");
		request.setAttribute("ScopeValue", "리퀘스트 영역");
		session.setAttribute("ScopeValue" , "세션 영역 ");
		application.setAttribute("ScopeValue" , "애플 영역");
	
	%>
	
	
	<p>페이지 영역 : ${ pageScope.ScopeValue } </p>
	<p>리퀘스트 영역 : ${ requestScope.ScopeValue }</p>
	<p>세션 영역 : ${sessionScope.ScopeValue }</p>
	<p>애플리케이션 영역 : ${ applicationScope.ScopeValue }</p>
	
	<hr> 
	
	<br> 
	<!-- 영역을 저장하지 않으면 가장 좁은 범위부터 속성 이름을 찾기 시작함  -->
	<p> ${ ScopeValue } </p>
</body>
</html>