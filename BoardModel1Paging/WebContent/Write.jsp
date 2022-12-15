<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ include file ="./IsLoggedIn.jsp" %> <!-- 로그인 검증  -->
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
	<h2> 회원제 게시판 - 글쓰기</h2>
	<form name = "writeFrm" method="post" action="WriteProcess.jsp" 
	onsubmit="return TextCheck(this);">
		<table border="1" width="90%"> 
			<tr>
				<td> 제목 </td>
				<td> 
					<input type="text" name="title" style="width: 90%;"/>
				</td>
			</tr>
			
			<tr>
				<td> 내용 </td>
				<td> 
					<textarea name="content" style="width:90%; height:100px;"> </textarea>
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