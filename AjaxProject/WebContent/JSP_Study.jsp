<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%! //선언부 (메서드 선언) 
public int add(int a , int b){
	return a + b;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<% // 스크립틀릿( 자바 코드 )
int result = add(20 , 30);
%>
<p>덧셈 결과 1 : <%=result %></p><br/> <!-- 표현식 (변수)-->
<p>덧셈 결과 2 : <%=add(30,30) %></p><br/> <!-- 표현식 (메서드 호출)-->

<!-- 	
		내장 객체의 특징 
	  - 컨테이너가 미리 선언해놓은 참조 변수를 이용해 사용
	  - 별도의 객체 생성 없이 각 내장 객체의 메서드를 사용 가능 
	  - JSP 문서 <%--스크립틀릿 --%> 과 <%--=표현식 --%>안에 에서만 사용할 수 있다.
	  - <%--!선언부--%> 에서는 즉시 사용하는 건 불가능하고, 매개변수로 전달받아 사용할수 있다.
	  
 -->
 
 <!-- 
	내장 객체의 종류 (가장 기본적인 5가지)  
	- request 		: 클라이언트의 요청 정보를 저장 (가장 많이 사용 )
						주요 기능 		
						- 클라이언트와 서버에 대한 정보 읽기
						- 클라이언트가 전송한 요청 매개변수에 대한 정보 읽기
						- 요청 헤더 및 쿠키 정보 읽기 
						
	- response 		: 클라이언트의 요청에 대한 응답 정보를 저장

	- out 			: JSP 페이지에 출력할 내용을 담는 출력 스트림 

	- application  	: 웹 에플리케이션 관련 컨텍스트 정보를 저장

	- exception   	: 예외가 발생한 경우에 사용 
 -->
 
 

</body>
</html>