<%@page import="java.util.*"%>
<%@page import="common.Person"%>
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

<h4> 일반 for 문 형태의 forEach 태그</h4>
<c:forEach begin="1" end="3" step="1" var="i">
	<p> ${i }반복 중 </p> 
</c:forEach>

<h4> varStatus 속성</h4>
<table border="1"> 
	<c:forEach begin="3" end="5" var="i" varStatus="loop">
		<tr> 
			<td> count : ${loop.count }</td>
			<td> index : ${loop.index}</td>
			<td> current : ${loop.current}</td>
			<td> first : ${loop.first  }</td>
			<td> last : ${loop.last }</td>
		</tr>
	</c:forEach>
</table>

<h4> 1 에서 100 까지 정수 중 홀 수의합</h4>
<c:forEach begin="1" end="100" var="j">
	<c:if test="${ j % 2 == 1}">
		<c:set var="sum" value="${ sum + j }"/>
	</c:if>
</c:forEach>
1~100사이의 정수 중 홀수의 합은? ${ sum }
<br/>
<br/>
<hr/>

<h4> 향상된 for문의 forEach태그 </h4>
 
 <%
 String array[] = {"red" , "green" , " blue" , " black"};
 %>
 <c:forEach items="<%=array %>" var = "c" >
 	<span style="color:${ c };"> ${ c }</span>
 </c:forEach>
 
 <h4> varStatus 속성 </h4>
 <table border="1"> 
	<c:forEach items="<%=array %>" var = "c" varStatus="loop">
		<tr> 
			<td> count : ${loop.count }</td>
			<td> index : ${loop.index}</td>
			<td> current : ${loop.current}</td>
			<td> first : ${loop.first  }</td>
			<td> last : ${loop.last }</td>
		</tr>
	</c:forEach>
</table>
<br/>
<br/>
<hr/>

<h4> List 컬렉션 사용 </h4>
<%
	LinkedList<Person> lists = new LinkedList<>();
	lists.add(new Person("a" , 11));
	lists.add(new Person("b" , 22));
	lists.add(new Person("c" , 33));
%>

<c:set var="lists" value="<%=lists %>"/>
<c:forEach items="<%=lists %>" var="list">
	<li> 이름 : ${list.name } , 나이 : ${list.age } </li>
</c:forEach>

<h4> Map 컬렉션 </h4>
<%
	Map<String , Person> maps = new HashMap<>();
	maps.put("1st" , new Person("a" , 11 ));
	maps.put("2st" , new Person("b" , 11 ));
	maps.put("3st" , new Person("c" , 11 ));
%>

<c:set var="maps" value="<%=maps %>"></c:set>
<c:forEach items="${maps }" var="map">
	<li>
		Key => ${map.key } <br/>
		Value => 이름 : ${map.value.name } , 나이 : ${map.value.age }
	</li>
</c:forEach>

<iframe src="http://www.daum.net" style="width:100%; height:600px;"></iframe>
</body>
</html>