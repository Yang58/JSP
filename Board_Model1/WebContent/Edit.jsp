<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="board.*" %>    
<%@ include file ="./IsLoggedIn.jsp" %> <!-- 로그인 검증  -->

<%
	// 삭제 메소드 
	String num = request.getParameter("num");
	BoardDAO dao = new BoardDAO(application);
	BoardDTO dto = dao.selectView(num);
	
	String checkId = session.getAttribute("UserId").toString();
	
	if(!checkId.equals(dto.getId())){
		JSFunction.alertBack("작성자 본인만 수정할 수 있습니다.", out);
		return;
	}
	dao.close();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script type="text/javascript">
	function TextCheck(form){
		if(form.title.value == ""){
			alert("제목을 입력해주세요 !");
			form.title.focue(); // 현재 페이지에서 포커스를 제목 입력하는 곳으로 이동 
			return false;
		}
		if(form.content.value ==""){
			alert("내용을 입력해주세요 !");
			form.content.focue(); // 현재 페이지에서 포커스를 제목 입력하는 곳으로 이동 
			return false;
		}
	}
</script>
</head>
<body>
	<h2> 회원제 게시판 - 수정하기</h2>
	<form name = "writeFrm" method="post" action="EditProcess.jsp" 
	onsubmit="return TextCheck(this);">
	<input type="hidden" name="num" value="<%=dto.getNum() %>"/>
		<table border="1" width="90%"> 
			<tr>
				<td> 제목 </td>
				<td> 
					<input type="text" name="title" style="width: 90%;"
							value="<%=dto.getTitle()%>"/>
				</td>
			</tr>
			<tr>
				<td> 내용 </td>
				<td> 
					<textarea name="content" style="width:90%; height:100px;"><%=dto.getContent()%></textarea>
				</td>
			</tr>
			<tr> 
				<td colspan="2" align="center">
					<button type="submit"> 작성 완료 </button>
					<button type="reset"> 다시 입력 </button>				
					<button type="button" onclick="location.href='List.jsp';"> 목록 보기 </button>
				</td>
			
			</tr>
		 </table>
	
	</form>
</body>
</html>