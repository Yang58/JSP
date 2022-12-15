<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h4> 숫자 포멧 설정 </h4>
	<c:set var="number1" value="12345"/>
	콤마 O : <fmt:formatNumber value ="${number1 }" /> <br/>
	콤마 X : <fmt:formatNumber value ="${number1 }" groupingUsed="false" /> <br/>
	<fmt:formatNumber value="${number1 }" type="currency" var="printNum1"></fmt:formatNumber>
	통화 기호 : ${ printNum1 } <br/>
	<fmt:formatNumber value="0.03" type="percent" var="printNum2"/>
	퍼센트 : ${printNum2}
	
	<br/>
	<br/>
	<hr/> 

	<c:set var="today" value="<%=new java.util.Date() %>"/>	
	
	<h4> 날짜 포멧 </h4>
	full : <fmt:formatDate value="${today}" type="date" dateStyle="full"/><br/>
	short : <fmt:formatDate value="${today}" type="date" dateStyle="short"/><br/>
	long : <fmt:formatDate value="${today}" type="date" dateStyle="long"/><br/>
	default : <fmt:formatDate value="${today}" type="date" dateStyle="default"/><br/>
	
		
	<h4> 시간 포멧 </h4>
	full : <fmt:formatDate value="${today}" type="time" timeStyle="full"/><br/>
	short : <fmt:formatDate value="${today}" type="time" timeStyle="short"/><br/>
	long : <fmt:formatDate value="${today}" type="time" timeStyle="long"/><br/>
	default : <fmt:formatDate value="${today}" type="time" timeStyle="default"/><br/>
	
	<h4> 날짜/시간 표시</h4>
	<fmt:formatDate value="${today }" type="both" dateStyle="full" timeStyle="full"/> <br/>
	<fmt:formatDate value="${today }" type="both" dateStyle="default" timeStyle="default"/> <br/>
	<fmt:formatDate value="${today }" type="both" pattern="yyyy-MM-dd hh-mm-ss"/>
</body>
</html>