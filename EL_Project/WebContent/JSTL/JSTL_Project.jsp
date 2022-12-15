<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="common.Person"%>
<%@page import="java.util.Date"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<c:set var = "directVar" value="100"/>
<c:set var = "elVar" value="${directVar mod 5}"/>
<c:set var = "expVar" value="<%=new Date() %>"/>
<c:set var = "betweenVar" value="변수 값 요렇게 설정"/>


<p> directVar : ${directVar} </p>
<p> elVar : ${elVar} </p>
<p> expVar : ${expVar} </p>
<p> betweenVar : ${betweenVar} </p>

<c:set var="personVar1" value='<%= new Person("홍" , 11) %>' scope="request"/>
<p>${requestScope.personVar1 } </p><br/>
<p>${requestScope.personVar1.name  } </p><br/>
<p>${requestScope.personVar1.age } </p><br/>


<c:remove var="personVar1" scope="request"/>
<p>${requestScope.personVar1.name  } </p><br/>
<p>${requestScope.personVar1.age } </p><br/>
</body>
</html>