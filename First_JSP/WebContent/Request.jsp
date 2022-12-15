<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<a href="./RequestWebInfo.jsp?eng=Hello&han=안녕"> Get 전송 방식</a>
	<br/>

	<form action="RequestWebInfo.jsp" method="post">
		영어 : <input type="text" name="eng" value="Bye" /> <br /> 
		한글 : <input type="text" name="han" value="잘 가" /> <br /> 
		<input type="submit"	value="Post 전송" />
	</form>
	<br>
	<br>
	<form method="post" action="RequestParameter.jsp">
		아이디 : 		<input type="text" name="id" value="" /> <br/>
		성별 : 		<input type="radio" name="sex" value="man" /> 남자 
			  		<input type="radio"	name="sex" value="woman" checked="checked" /> 여자 <br /> 
			  		
		관심 사항 : 	<input	type="checkbox" name="favo" value="eco" /> 경제 
		 			<input type="checkbox"	name="favo" value="pol" checked="checked" /> 
		 정치 		<input	type="checkbox" name="favo" value="ent" /> 연예 <br /> 
		자기소개 :	<br /> 	<textarea rows="5" cols="30" name="intro"></textarea><br /> 
		
		<input type="submit" value="전송하기" />
	</form>
	
</body>
</html>