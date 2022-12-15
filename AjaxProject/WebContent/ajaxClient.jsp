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
      $("#buttonSubmit").on("click" , function(){
          
         $.ajax({ // ajax 의 기본 형식 
            // 서버에게 보내는 정보 
            url:'./ajaxServer.jsp',
            type:'post',
            data:{ nickName : '멍멍이'},
            // 클라이언트가 받는 정보 
            dataType : 'json',
            // 서버에서 클라이언트로 데이터를 성공적으로 전달받았을때 실행되는 함수
            success:function(data){  //data(매개변수 아무렇게 적어도 됨) = {"nickName": "멍멍이"}객체를 통으로 받음
               console.log(data.nickName); 
               console.log("요청 성공");
               $("#nickName").text(data.nickName);
            }
         });
      });
   });
</script>

</head>

<body>
   <input id="buttonSubmit" type="button" value="제출">
   <p id="nickName"></p>
   <p>ajax 통신 성공</p>
</body>
</html>