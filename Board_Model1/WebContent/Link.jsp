<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
	#checkID{
		align : right;
		margin-right: 10px;
	}
</style>
<body>
	<table border="1" width="100%" > 
	<tr> 
		<td align="center" > 
			<% if (session.getAttribute("UserId") == null) {  %>
				<a href="./LoginForm.jsp"> 로그인 </a>	
			<%} else {%>
				<a href="./Logout.jsp"> 로그아웃 </a>
			<%} %>
			&nbsp;&nbsp;&nbsp;
			<a href="./CommonList.jsp"> 게시판 (페이징 X)</a>
			&nbsp;&nbsp;&nbsp;
			<a href="./PagingList.jsp"> 게시판 (페이징 O)</a>
		</td>
		<%
			if(session.getAttribute("UserId") != null){
				String userID = session.getAttribute("UserId").toString();
		%>
				<td id="checkID"><%=session.getAttribute("UserName")%> 회원님</td> 
		<%
			} else {
		%>		
				<td id="checkID"> 로그인해주세요</td>
		<% 
			}
		%>

	</tr>
	</table>

</body>
</html>