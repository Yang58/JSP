<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.*" %>
<%@ include file = "IsLoggedIn.jsp" %> <!-- 로그인 체크   -->

<%
	String num = request.getParameter("num"); // 쿼리 스트링으로 인덱스 데이터를 받음 
	BoardDAO dao = new BoardDAO(application); // DB생성
	BoardDTO dto = new BoardDTO(); 
	dto = dao.selectView(num);
	
	
	// 로그인된 사용자 ID 얻기 
	String sessionId = session.getAttribute("UserId").toString();
	
	int delResult = 0 ; 
	
	if(sessionId.equals(dto.getId())){ // 작성자 본인이 맞는지 확인 
		dto.setNum(num); // 게시글의 인덱스 번호를 세팅 
		delResult = dao.deletePost(dto); // dto객체를 넘겨 삭제 쿼리문 실행 
		dao.close();
		
		if(delResult == 1){
			// 삭제 성공 
			JSFunction.alertLocation("삭제되었습니다." , "List.jsp", out);
		}else{
			JSFunction.alertBack(" 삭제 실패. ", out);
		}
	}else{
		JSFunction.alertBack("작성자만 삭제할 수 있습니다.", out);
		return;
	}
	

%>
