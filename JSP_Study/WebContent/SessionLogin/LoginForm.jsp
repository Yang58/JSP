<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<span style="color:red;">
		<%=request.getAttribute("LoginErrMsg") == null ? "" : request.getAttribute("LoginErrMsg") %>
	 </span>
<%
	if(session.getAttribute("UserId") == null){
%>	
	<script type="text/javascript">
		function validateFrom(form){
			if(!form.user_id.value){
				alert("아이디 입력 !! ")
				return false;
			}
			if(!form.user_pw.value){
				alert("패드워드 입력 !! ")
				return false;
			}
		}
	</script>
	
	<form action="LoginProcess.jsp" method="post" onsubmit="return validateFrom(this)"> 
		아이디 : <input type="text" name="user_id"><br>
		비밀번호 : <input type="password" name="user_pw"><br>
		<input type="submit" value="로그인">
	</form>
<% 
	}else{
%>
		<%=session.getAttribute("UserName") %> 님 어서오세요 <br>
		<a href="Logout.jsp"> </a>
<%	
	}
%>
</body>
</html>