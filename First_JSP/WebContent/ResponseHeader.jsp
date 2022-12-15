<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.util.Collection" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
	request.setCharacterEncoding("UTF-8");
	// 클라이언트에서 받은 정보 
	String date = request.getParameter("add_date");
	String aint = request.getParameter("add_int");
	String str = request.getParameter("add_str");
	
	
	// 클라이언트에게 보내는 정보 
	// 헤더에 데이터 저장 ( 변수명 , 데이터 )
	response.addHeader("myHeader1", date);
	response.addHeader("myHeader2", aint);
	response.addHeader("myHeader3", str);
%>
<body>

<%
	// 헤더에 저장되어있는 Name(변수명)을 모두 가져와 Collection타입으로 받음 
	Collection<String> names = response.getHeaderNames();
	out.print("out name : "+names + "\n");
	// Collection 타입으로 받은 Name 을 반복문을 통해 출력 
	for(String s : names){ 
		out.print("out s : " + s );
		String value = response.getHeader(s);	
%>
	<p>data : <%=value %></p>
<% 	}
	
%>
<p> 쿼리스트링 : <%= request.getQueryString() %> </p>
</body>
</html>