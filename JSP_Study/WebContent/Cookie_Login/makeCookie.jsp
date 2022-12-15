<%@page import="login_src.AlertManager"%>
<%@page import="login_src.CookieManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

 <%
 /* CookieMain에서 받은 정보로 로그인 처리 */
 
 	String id = request.getParameter("user_id");
 	String pw = request.getParameter("user_pw");
 	String check = request.getParameter("save_check");
 	
 	
 	// 아이디 패스워드 확인
 	if(id.equalsIgnoreCase("yang") && pw.equalsIgnoreCase("1111")){
 		// 체크 값 확인
 		if(check != null && check.equals("Y")){
 			CookieManager.MakeCookie(response, "user_id", id, 60);
 		}
 		// 체크를 안했다면 쿠키 삭제 
 		else{
		 	CookieManager.DeleteCookie(response, "user_id");
 		}
 		
 		AlertManager.alertView("성공", "CookieMain.jsp", out);
 	}else{ // 로그인 실패 
 		AlertManager.alertBack("실패", out);
 	}
 %>