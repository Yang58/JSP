<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="common.Person" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>page 영역 1</title>
</head>
<%
	// setAttribute(변수명 , 값) : 값 추가 메소드 Object 타입이기떄문에 모든 타입 가능 
	pageContext.setAttribute("pageInteger", 1000);
	pageContext.setAttribute("pageString", "페이지 영역의 문자열");
	pageContext.setAttribute("pagePerson", new Person("page_area" , 100));
%>
<body>

<h2> page 영역의 속성 값 읽기 </h2>
<%
	// 값을 읽어오기 위해 캐스팅 필요 
	int pageInt = (Integer)(pageContext.getAttribute("pageInteger"));
	String pageStr = (String)(pageContext.getAttribute("pageString"));
	Person pagePer = (Person)(pageContext.getAttribute("pagePerson"));
%>
	
	<h3> page영역의 데이터</h3>
<ul>
	<li><%=pageInt %></li>
	<li><%=pageStr %></li>
	<li><%=pagePer %></li>
	<li><%=pagePer.getName() %> , <%=pagePer.getAge() %></li>
</ul>

<h2> 페이지 이동 후 page 영역 읽어오기 </h2>
<a href="PageLocation.jsp">PageLocation.jsp 바로가기</a> 

<br><br>
<hr> 

<!-- ------------------------------------------------------------------------------ -->
<h2> request 영역 </h2>
<%
	request.setAttribute("reString", "request 영역의 문자열");
	request.setAttribute("rePerson", new Person("requestPer" , 1000));
	Person rePerson = (Person)(request.getAttribute("rePerson"));
%>

<ul>
	<li><%=request.getAttribute("reString") %></li>
	<li><%=rePerson.getName() %> , <%=rePerson.getAge() %></li>
</ul>


<!-- 
 request 방식은 forword 방식으로 페이지 이동
 request.getRequestDispatcher("RequestForword.jsp").forward(request, response);
 -->

</body>
</html>