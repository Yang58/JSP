<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
	String id = request.getParameter("id");
	String sex = request.getParameter("sex");
	
	//클라이언트에서 선언한 checkBox는 배열 형태로 서버에 전달 
	String[] favo = request.getParameterValues("favo");
	String favoStr = ""; 
	for(String a : favo){
		favoStr += a + " ";
	}
	String intro = request.getParameter("intro"); // 줄 바꿈 무시  
	out.print(intro);
	String intro1 = request.getParameter("intro").replace("\r\n" , "<br/>"); 
	out.print(intro1);
%>


</head>
<body>

<ul>
	<li> 아이디 : <%= id %></li>
	<li> 성별 : <%=sex %></li>
	<li> 관심사항 : <%=favoStr %></li>
	<li> 자기소개 : <%=intro %></li>
	<li> 자기소개 : <%=intro1 %></li>
</ul>

</body>
</html>