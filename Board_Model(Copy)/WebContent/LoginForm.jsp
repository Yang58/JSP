<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:include page="Link.jsp"/>
<h2> 로그인 페이지 </h2>
<span style="color:red; font-sizeL 1.2eml">
	<%=request.getAttribute("LoginErrMsg") == null ? "" : request.getAttribute("LoginErrMsg") %>
</span>
 <%
 	if(session.getAttribute("UserId") == null){
 %>
		 <script type="text/javascript">
		 	function validateForm(form){
		 		if(!form.user_id.value){
		 			alert("아이디를 입력하세요");
		 			return false;
		 		}
		 		if(form.user_pw.value == ""){
		 			alert("패드워드를 입력하세요");
		 			return false;
		 		}
		 	}
		 	
		 </script>
		  <!--  submit으로 데이터를 주고받는 방법 
		  			this를 통해 script로 input 객체의 데이터를 매개변수로 넘겨줌
		  			onsubmit : script에서 함수를 사용해 지정한 값을 매개변수로 받아 함수 실행 -> 값을 form -> script로 넘겨줌
		  			document.getElementById("ID").submit(); : script에서 값을 받아오는 형식 
		    -->
		 <form action="LoginProcess.jsp" method="post" name="loginFrm" onsubmit="return validateForm(this)">
		 	아이디	: <input type="text" name="user_id" > <br/>
		 	패스워드	: <input type="password" name="user_pw" > <br/>
		 	<input type="submit" value="로그인"/>
		 </form>
 
 <%
	 } else{
 %>
		<%= session.getAttribute("UserName") %> 회원님 , 로그인하셨습니다. <br/> 
		<a href="Logout.jsp"> [로그아웃]</a>
 <%
 	 }
 %>
 
</body>
</html>