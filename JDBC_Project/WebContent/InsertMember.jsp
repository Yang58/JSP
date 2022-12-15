<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="common.JDBConnect" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2> 회원 추가 테스트 (executeUpdate() 사용)</h2>
	<%
		JDBConnect jdbc = new JDBConnect();
	
	
		 
		//DB에 하드코딩으로 데이터 삽입 
		String id = "test4";
		String pass = "3333";
		String name = "테스트4회원";
		
		
		 	/* ? : 인파라미터 ( 나중에 입력 ) 
			setString(인덱스 , 값 ) 을이용해 인파라미터에 값을 삽입
			setString의 인덱스는 1번 부터 시작하고 인덱스 1번 : 인파라미터 1번으로 연결되며 데이터 저장  */
				
		
		String sql = "INSERT INTO member VALUES (?,?,?,sysdate)";
		PreparedStatement psmt = jdbc.conn.prepareStatement(sql);
		psmt.setString(1,id);
		psmt.setString(2, pass);
		psmt.setString(3, name);
		
		/* 
		int inResult = psmt.executeUpdate(); // 쿼리 문 실행 
		out.println(inResult + "행이 입력되었습니다. <br/>"); 
		*/
		
		// DB 데이터 읽기 
		String selectSQL = "SELECT id , pass , name , regidate FROM member";
		Statement stmt = jdbc.conn.createStatement();
		
		ResultSet rs = stmt.executeQuery(selectSQL); // 테이블을 가르킴  
		
		while(rs.next()){  // 레코드 단위로 한칸씩 이동  .next() 다음 값이 있으면 true 없으면 false 리턴 
			String id1 = rs.getString(1);  //getString(컬럼의 인덱스 값 or "컬럼명")
			String pw1 = rs.getString(2);
			String name1 = rs.getString(3);
			// String name2 = rs.getString("name");
			
			java.sql.Date regidate = rs.getDate("regidate");
			
			out.println(String.format("%s / %s / %s / %s " , id1 , pw1 , name1 , regidate) + "<br/><hr/>");
		}
		
		
		//  ResultSet (rs) > PreparedStatement (psmt) <=> Statement (stmt) > Connection : (con)  는 사용후 반드시 닫아줘야함 
		
		jdbc.close();
	%>
</body>
</html>