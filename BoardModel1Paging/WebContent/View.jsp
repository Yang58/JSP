<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="board.BoardDAO" %>
<%@ page import="board.BoardDTO" %>
<%
	String num = request.getParameter("num");
	
	BoardDAO dao = new BoardDAO(application);
	dao.updateVisitCount(num);
	out.print(num);
	BoardDTO dto = dao.selectView(num);
 	dao.close(); 

%>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
	<script type="text/javascript">
		function deletePost(){
			// 예(True) 아니요(false)
			var confirmed = confirm("정말로 삭제 하시겠습니까?");
			if(confirmed){
				var form = document.writeFrm; 		// form 이름이 writeFrm 것을 선택 
				form.method = "post"; 				// 전송 방식 선택
				form.action = "DeleteProcess.jsp"; 	// 전송 경로 선택 
				form.submit();						// 폼값 전송 
			}
		}
	
	</script>
<body>
	<jsp:include page="Link.jsp"/>
	
	<h2> 회원제 게시판 - 상세 보기</h2>
	<form name="writeFrm">
		<input type = "hidden" name ="num"	value="<%=num %>"/>
		<table border="1" width="90%">
			<tr>
				<td>번호</td>
				<td><%=dto.getNum()%></td>
				<td>작성자</td>
				<td><%=dto.getName()%></td>
			</tr>
			<tr>
				<td>작성일</td>
				<td><%=dto.getDate() %></td>
				<td>조회수</td>
				<td><%=dto.getVisitcount()%></td>
			</tr>
			<tr>
				<td>제목</td>
				<td colspan="3"> <%=dto.getTitle() %></td>
			</tr>
			<tr>
				<td>내용</td>
				<td colspan="3" height="100">
					<%=dto.getContent().replace("\r\n", "<br>")%> </td>
			</tr>
			<tr>
				<td colspan="4" align="center">
					<%
					if(session.getAttribute("UserId") != null 
						&& session.getAttribute("UserId").toString().equals(
								dto.getId())){
					%>
					<button type="button" onclick="location.href='Edit.jsp?num=<%= dto.getNum()%>';">
					수정 하기</button>
					<button type="button" onclick="deletePost();">삭제 하기</button>
					<%
					}
					%>
					<button type="button" onclick="location.href='List.jsp';">목록보기</button>
					
				 </td>
			</tr>
		</table>
	</form> 
</body>
</html>