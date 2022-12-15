<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
	Cookie cookie = new Cookie("my" , "cook");
	cookie.setPath(request.getContextPath()); // 쿠키 저장 경로 
	cookie.setMaxAge(3600);
	response.addCookie(cookie);
%>
<body>
<h2> 쿠키 설정 직후 쿠키값 확인 </h2>
<%
	Cookie[] cookies = request.getCookies();
	if(cookies != null){	
		for(Cookie c : cookies){
			String cookieName = c.getName();
			String cookieValue	= c.getValue();
			
			out.print(String.format(" %s : %s <br>" , cookieName , cookieValue));
		}
	}
%>

<h2> 페이지 이동 후 쿠키값 확인</h2>
<a href="CookieResult.jsp" > 페이지 이동 </a>
</body>
</html>