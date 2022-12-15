<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="membership.MemberDAO" %>
<%@ page import="membership.MemberDTO" %>

<%
	String userId = request.getParameter("user_id");
	String userPw = request.getParameter("user_pw");

	String driver = application.getInitParameter("OracleDriver");
	String url = application.getInitParameter("OracleUrl");
	String id = application.getInitParameter("OracleId");
	String pwd =application.getInitParameter("OraclePwd");
	
	MemberDAO dao = new MemberDAO(driver, url , id , pwd);
	System.out.println("MEMBER_TABLE : DB 연결 성공 ");
	MemberDTO dto = dao.getMemberDTO(userId, userPw);
	dao.close();
	
	if(dto.getId() != null){
		session.setAttribute("UserId" , dto.getId());
		session.setAttribute("UserName", dto.getName());
		response.sendRedirect("LoginForm.jsp");
	}else{
		request.setAttribute("LoginErrMsg", "로그인 실패");
		request.getRequestDispatcher("LoginForm.jsp").forward(request, response);
	}
%>