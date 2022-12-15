<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ page import="common.Person" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>


<jsp:useBean id="person" class="common.Person" scope="request"></jsp:useBean>
<jsp:setProperty property="name" name="person" value="임꺽정"/>
<jsp:setProperty property="age" name="person" value="11"/>

<jsp:getProperty property="name" name="person"/>
<jsp:getProperty property="age" name="person"/>

	<%
		Person p = new Person();
		p.setName("임꺽정");
		p.setAge(20);
		out.print(p.getName());
		out.print(p.getAge());
	
		
		/* 
		액션태그를 자바코드로 변경 
			Person p1 = (Person)request.getAttribute("person");
			if(person == null){
				person = new Person();
				request.setAttribute("person", person);
			} 
		*/
		
/* 		String name = (String)request.getAttribute("name");
		int age = (Integer)request.getAttribute("age");
		
		out.print(String.format("%s / %d" , name , age));
		out.print(String.format("%s / %d" , request.getAttribute("name") , (Integer)request.getAttribute("age"))); */
	
	%>

</body>
</html>