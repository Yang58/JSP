<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style> 
	a{ text-decoration: none; }
</style>
</head>
<body>
	
	<h2 style="text-align: center;" > 파일 첨부형 게시판 - 목록 보기(List) </h2>
	
	<form method="get"> <!-- action= " http://localhost:8081/MVC2_BoardModel/mvcboard/list.do "  -->
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
			<th width="*">제목</th>
			<th width="15%">작성자</th>
			<th width="10%">조회수</th>
			<th width="15%">작성일</th>
			<th width="8%">첨부</th>
		</tr>
		
		<!-- 게시물이 없을떄  -->
		<c:choose>
			<c:when test="${empty boardLists }">
				<tr>
					<td colspan="6" align="center">등록된 게시물이 없습니다~^^*</td>
				</tr>
			</c:when>
		<!-- 게시물이 있을때  -->
			<c:otherwise>
				<c:forEach items="${boardLists }" var="row" varStatus="loop"> 
					<tr align="center">
						<!-- 게시물 번호 출력 (전체 게시물의 개수 ((( 현재 페이지 넘버 -1 ) * 한페이지에 보일 게시물의 개수 ) + 반복 횟수   -->
						<td> ${map.totalCount - (((map.pageNum -1) * map.pageSize) + loop.index) } </td>
						<td> ${row.title }</td>
						<td> ${row.name }</td>
						<td> ${row.visitcount }</td>
						<td> ${row.postdate }</td>
						<td> [DOWN]</td>
					</tr>
				</c:forEach>
			</c:otherwise>
		
		</c:choose>
	</table>
	
	<!-- 하단 메뉴 ( 바로가기 , 글쓰기 )  -->
	<table border = "1" width="100%">
		<tr align="center">
			<!-- 페이징 -->
			<td> ${ map.pagingImg }</td>
			
			<td width="100"> <button type="button"> 글쓰기 </button></td>
		</tr>
	</table>
</body>
</html>