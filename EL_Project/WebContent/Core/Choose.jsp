<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:set var="number" value="100"/>
	
	<h4> 홀짝 판단</h4>
	<c:choose> 
		<c:when test="${number % 2 == 0 }">
			${number}는 짝수 입니다. 
		</c:when>
		
		<c:otherwise>
			${number}는 홀수 입니다.
		</c:otherwise>
	</c:choose>

	<form> <!-- method , action 생략 default : get , 자기 자신의 url 주소  -->
		 <input type="text" name="kor"/> <br/>
		 <input type="text" name="eng"/> <br/>
		 <input type="text" name="math"/> <br/>
		 <input type="submit" value="학점 구하기"/>
	</form>	
	
	<c:if test=" ${ not (empty param.kor or empty param.eng or empty param.math) }">
	
		<c:set var="avg" value="${ (param.kor + param.eng + param.math) / 3 }"/>
			평균 점수는 ${ avg } 으로, 
		<c:choose>
			<c:when test="avg >= 90"> A학점</c:when>
			<c:when test="avg >= 80"> B학점</c:when>
			<c:when test="avg >= 70"> C학점</c:when>
			<c:when test="avg >= 60"> D학점</c:when>
			<c:otherwise> F학점 </c:otherwise>
		</c:choose>
		입니다.
	</c:if>
</body>
</html>