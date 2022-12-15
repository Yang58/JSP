<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.BoardDTO"%>
<%@ page import="board.BoardDAO"%>
<%@ include file ="./IsLoggedIn.jsp" %> <!-- 로그인 검증  -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<% 

	// Write에서 입력한 Form 값을 받아옴 
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	
	// 폼값을 DTO 객체에 저장
	BoardDTO dto = new BoardDTO();
	dto.setTitle(title);
	dto.setContent(content);
	dto.setId(session.getAttribute("UserId").toString());
	
	
	// DAO 객체를 통해 DB에 DTO 저장
	BoardDAO dao = new BoardDAO(application);
	int iresult = dao.insertWrite(dto);
	dao.close();
	
	if(iresult == 1){
		response.sendRedirect("List.jsp");
		
	}else{
		JSFunction.alertBack("글 쓰기 업로드 실패 ", out);
	}
	
	// 성공 or 실패 
%>
</head>
<body>


</body>
</html>