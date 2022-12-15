<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.*" %>
<%@ include file="IsLoggedIn.jsp" %>

<%
	String num = request.getParameter("num");
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	
	BoardDTO dto = new BoardDTO();
	
	dto.setNum(num);
	dto.setTitle(title);
	dto.setContent(content);
	
	BoardDAO dao = new BoardDAO(application);
	int affeted = dao.updateEdit(dto);
	dao.close();
	
	if(affeted == 1){
		response.sendRedirect("View.jsp?num=" + dto.getNum());
	}else{
		JSFunction.alertBack("수정하기 실패", out);
	}
%>