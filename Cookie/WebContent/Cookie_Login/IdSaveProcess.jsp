<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="utils.CookieManager" %>
<%@ page import="utils.JSFunction" %>
<%
	String user_id = request.getParameter("user_id");
	String user_pw = request.getParameter("user_pw");
	String save_check = request.getParameter("save_check");
	
	if("must".equals(user_id) && "1234".equals(user_pw)){
		if(save_check != null && save_check.equals("Y")){ // 아이디 저장하기를 체크했는지 확인 
			// 체크가 되어있다면 쿠키 생성 
			//( response , (Cookie_ID : loginId) ,( Cookie_Value : user_id ), 쿠키 시간 )
			CookieManager.makeCookie(response, "loginId", user_id, 3600);
		}else{
			// 체크가 되어있지 않다면 쿠키의 값 삭제 
			CookieManager.deleteCookie(response, "loginId");
		}
		
		JSFunction.alertLocation("로그인 성공", "IdSave.jsp", out);
	}else{
		JSFunction.alertBack("로그인 실패", out);
	}
	
%>