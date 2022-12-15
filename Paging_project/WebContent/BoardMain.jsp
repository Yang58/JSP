<%@page import="JDBC.DTO"%>
<%@page import="java.util.List"%>
<%@page import="JDBC.DAO"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<%
	DAO dao = new DAO(application);
	Map<String , Object> map = new HashMap<>();
	
	String searchF = request.getParameter("searchField");
	String searchW = request.getParameter("searchWord");
	
	if(searchW != null){
		map.put("Field", searchF);
		map.put("Word" , searchW);
	}
	int totalCount = dao.BoardSize(map);
	List<DTO> boardList = dao.Search(map);
	dao.close();


%>
</head>
<body>
	
	
	<h2 align="center" style="margin-right:100px; "> 목록 보기 </h2>
	
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
			if(boardList.isEmpty()){
		%>
				<tr> 
					<td colspan="5" align="center"> 등록된 게시물이 없습니다~ *^^</td>
				</tr>
		<% 
			// return 값이 있다면 ( 게시글 List 리턴 값 존재 )
			} else {
				int virtualNum = 0;
				int countNum = 0 ;
				for(DTO dto : boardList){
					virtualNum = totalCount--;
					
		%>
					<tr align="center">									
						<td><%=virtualNum%></td>
						<td align="left">
							<a href="View.jsp?num=<%=dto.getNum()%>"> <%=dto.getTitel()%></a>
						</td>
						<td align="center"> <%=dto.getId()%></td>
						<td align="center"> <%=dto.getVisitcount()%></td>
						<td align="center"> <%=dto.getPostdate()%></td>
					</tr>
		<%
				}	
			}
		%>
		
		
	</table>
	
	<table border="1" width="90%">
		<tr align="center">
			<td>
				<button type="button" onclick="location.href='Write.jsp';"> 글쓰기 </button>
			</td>
		</tr>
	</table>
</body>
</html>