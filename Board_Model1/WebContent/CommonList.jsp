<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ page import="board.BoardDAO" %>
<%@ page import="board.BoardDTO" %>

<%
	BoardDAO dao = new BoardDAO(application); // DB연결 
	Map<String , Object> param = new HashMap<>(); //검색할 부분과 내용을 담을 Map 생성 
	
	// request 영역에 찾는 데이터가 있는지 확인  폼값으로 넘어온 데이터가 있는지 확인 
	String searchField = request.getParameter("searchField"); 
	String searchWord = request.getParameter("searchWord");
	// 찾는 단어가 null이 아니면 Map에 데이터 추가 
	if(searchWord != null){
		param.put("searchField",searchField);
		param.put("searchWord",searchWord);
	}
	// dao class의 게시글의 총 개수를 반환하는 메소드와 그 게시글들을 반환하는 메소드를 호출
	int totalCount = dao.selectCount(param); // 화면에 출력할 게시물의 수 
	List<BoardDTO> boardList = dao.selectList(param); // 
	dao.close();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="Link.jsp"></jsp:include>
	
	<h2 align="center" style="margin-right:100px; "> 목록 보기 </h2>
	
	<form method="get"> <!-- action 속성이 생략된 경우 자기 자신의 주소가 action 속성이 된다 ( 재귀 호출? )
		submit 할때 폼값을 쿼리스트링으로 자신Url에 포함시켜 보냄  -->
		<table border="1" width="100%"> 
			<tr> 
				<td align="center"> 
					<select name="searchField">
						<option value="title"> 제목 </option>
						<option value="content"> 내용 </option>
					</select>
					<input type="text" name="searchWord"/>
					<input type="submit" value="검색하기"/>
				</td>
			</tr>
		</table>
	</form>


	<table border="1" width="100%">
		<tr>
			<th width="10%">번호</th>
			<th width="50%">제목</th>
			<th width="15%">작성자</th>
			<th width="10%">조회수</th>
			<th width="15%">작성일</th>
		</tr>
		
		<%
			// DAO 객체에서 LIST에 값이 null이라면 
			if(boardList.isEmpty()){
		%>
				<tr> 
					<td colspan="5" align="center"> 등록된 게시물이 없습니다~ *^^</td>
				</tr>
		<% 
			// selectlist메소드를 통해 받은 값으로 반복문 실행 
			} else {
				int virtualNum = 0;
				for(BoardDTO dto : boardList){ // ArrayList<DTO> 
					virtualNum = totalCount--;
		%>
					<tr align="center">									
						<td><%=virtualNum%></td>
						<td align="left">
							<!--  쿼리 스트링으로 데이터 전송  -->
							<a href="View.jsp?num=<%=dto.getNum()%>"> <%=dto.getTitle()%></a>
						</td>
						<td align="center"> <%=dto.getId()%></td>
						<td align="center"> <%=dto.getVisitcount()%></td>
						<td align="center"> <%=dto.getDate()%></td>
					</tr>
		<%
				}	
			}
		%>
		
		
	</table>
	
	<table border="1" width="100%">
		<tr align="right">
			<td> 
				<button type="button" onclick="location.href='Write.jsp';"> 글쓰기 </button>
			</td>
		</tr>
	</table>
</body>
</html>