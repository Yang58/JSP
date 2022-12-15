<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script type="text/javascript">
	$(function(){
		$("#buttonSubmit").on('click', function() {
			$.ajax({
				url:'./ajaxServer4.jsp',
				type:'post',
				data: $("#theform").serialize(), // 데이터 직렬화 
				dataType:'json',
				success: function(res){
					alert("dd" + res);
					
					$("#result_name").text(res.name);
					$("#result_ph_number").text(res.ph_number);
					$("#result_address").text(res.address);
				},
				error: function(error){
					alert("ff" + error);
				}				
			});
		});
	});
</script>
</head>
<body>
	<form id="theform">
		<table border="1">
			<tr>
				<th>이름</th>
				<td><input type="text" id="name" name="name"></td>
			</tr>
			<tr>
				<th>번호</th>
				<td><input type="text" id="ph_number" name="ph_number">
				</td>
			</tr>
			<tr>
				<th>주소</th>
				<td><input type="text" id="address" name="address"></td>
			</tr>
		</table>
		<br /> <input id="buttonSubmit" type="button" value="제출" />
	</form>
	<br />
	<br />
	<table border="1">
		<tr>
			<th>[확인] 이름</th>
			<td style="width: 200px;"><span id="result_name"> </span></td>
		</tr>
		<tr>
			<th>[확인] 번호</th>
			<td><span id="result_ph_number"> </span></td>
		</tr>
		<tr>
			<th>[확인] 주소</th>
			<td><span id="result_address"> </span></td>
		</tr>
	</table>

</body>
</html>