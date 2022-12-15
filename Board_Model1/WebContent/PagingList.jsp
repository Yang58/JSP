<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ page import="board.BoardDAO" %>
<%@ page import="board.BoardDTO" %>
<%@ page import="utils.BoardPage" %>

<%
	BoardDAO dao = new BoardDAO(application); // DB연결 
	Map<String , Object> param = new HashMap<>(); //검색할 부분과 내용을 담을 Map 생성 
	
	// request 영역에 찾는 데이터가 있는지 확인 
	String searchField = request.getParameter("searchField");
	String searchWord = request.getParameter("searchWord");
	// 찾는 단어가 null이 아니면 Map에 데이터 추가 
	if(searchWord != null){
		param.put("searchField",searchField);
		param.put("searchWord",searchWord);
	}
	// dao class의 게시글의 총 개수를 반환하는 메소드와 그 게시글들을 반환하는 메소드를 호출
	int totalCount = dao.selectCount(param);

	// 페이지 처리 계산 start 
	int pageSize = Integer.parseInt(application.getInitParameter("POSTS_PER_PAGE"));
	int blockPage = Integer.parseInt(application.getInitParameter("PAGES_PER_BLOCK"));
	int totalPage = (int)Math.ceil((double)totalCount / pageSize); // 총 페이지 수 리턴 
	
	int pageNum = 1 ;
	String pageTemp = request.getParameter("pageNum");
	if(pageTemp != null && !pageTemp.equals("")){
		pageNum = Integer.parseInt(pageTemp);
	}
	
	int start = (pageNum-1) * pageSize + 1; // 첫 게시글 번호
	int end = pageNum * pageSize;  // 마지막 게시글 번호 
	param.put("start" , start);
	param.put("end",end);
	
	List<BoardDTO> boardLists = dao.selectListPage(param);
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
	
	<h2 align="center" style="margin-right:100px; "> 목록 보기 - 현재 페이지 : <%= pageNum %> 전체 : <%=totalPage %> </h2>
	
	<form method="get"> <!-- action 속성이 생략된 경우 자기 자신의 주소가 action 속성이 된다 ( 재귀 호출? )  -->
		<table border="1" width="90%"> 
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


	<table border="1" width="90%">
		<tr>
			<th width="10%">번호</th>
			<th width="50%">제목</th>
			<th width="15%">작성자</th>
			<th width="10%">조회수</th>
			<th width="15%">작성일</th>
		</tr>
		
		<%
			// DAO 객체에서 LIST에 값이 null이라면 
			if(boardLists.isEmpty()){
		%>
				<tr> 
					<td colspan="5" align="center"> 등록된 게시물이 없습니다~ *^^</td>
				</tr>
		<% 
			// return 값이 있다면 ( 게시글 List 리턴 값 존재 )
			} else {
				int virtualNum = 0;
				int countNum = 0;
				for(BoardDTO dto : boardLists){
					// virtualNum = totalCount--; 기존 코드 
					virtualNum = totalCount - (((pageNum -1) * pageSize) + countNum++);
		%>
					<tr align="center">									
						<td><%=virtualNum%></td>
						<td align="left">
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
	
	<table border="1" width="90%">
		<tr align="center">
			<!-- 페이징 처리  -->
			<td> 
				<%=BoardPage.pagingStr(totalCount, pageSize, blockPage, pageNum, request.getRequestURI())%>
			</td>
			<td>
				<button type="button" onclick="location.href='Write.jsp';"> 글쓰기 </button>
			</td>
		</tr>
	</table>
</body>
</html>