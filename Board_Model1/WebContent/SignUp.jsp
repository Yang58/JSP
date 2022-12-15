<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="board.*" %>
<%
	

%>

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function check(form){
		if(!form.id.value){
			alert("아이디 입력 확인");
			return false;
		}
		if(!form.pw1.value&&!form.pw2.value || form.pw1.value != form.pw2.value){
			alert("비밀번호 입력 확인");
			return false;
		}
		if(!form.name.value){
			alert("이름 입력 확인 ");
			return false;
		}
	}

</script>
</head>
<body>
	<h3> 회원 가입 페이지 </h3>
	<form name="signFrm" method="post" action="SignProcess.jsp" onsubmit="return check(this)"> 
		아이디 	   : <input type="text" name="id" />
		비밀번호 	   : <input type="password" name="pw1"/> 
		비밀번호 확인  : <input type="password" name="pw2"/> 
		이름 		   : <input type="text" name="name"	/>
		
		<input type="submit" value="가입 완료"/>
 	</form>
</body>
</html>