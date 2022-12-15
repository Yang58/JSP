<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.sql.*" %>
<%@ page import="common.JDBConnect" %>
<%@ page import="common.CreateTable" %>

<%
	JDBConnect scott = new JDBConnect();

	// 데이터 수정 
	/* String updateSQL = "update emp01 set deptno = ? where deptno = ?";
	PreparedStatement psmt2 = scott.conn.prepareStatement(updateSQL);
	psmt2.setInt(1, 10);
	psmt2.setInt(2, 30);
	psmt2.executeUpdate(); */
	
	// 데이터 삭제 
	/* String deleteSQL = "delete from emp01 where deptno = ?";
	PreparedStatement psmt3 = scott.conn.prepareStatement(deleteSQL);
	psmt3.setInt(1, 20);
	psmt3.executeUpdate(); */


	String sql = "select * from emp01";
	Statement stmt = scott.conn.createStatement();
	ResultSet rs = stmt.executeQuery(sql);
	
	out.print("<table style='border: 3px double black;'>");
	while(rs.next()){
		int empno = rs.getInt("EMPNO");
		String ename = rs.getString("ENAME");
		String job = rs.getString("JOB");
		int mgr = rs.getInt("MGR");
		java.sql.Date hiredate = rs.getDate("HIREDATE"); // String type 으로도 가능 
		int sal = rs.getInt("SAL");
		int comm = rs.getInt("COMM");
		int deptno = rs.getInt("DEPTNO");
		
		/* 	out.print(empno +" / " + ename+" / "+ job+" / " + mgr+" / " +hiredate+" / "
			+sal+" / " + comm+" / "+ deptno); */
		
		/* out.print(String.format("%s 번 %s %s %s %s %s %s %s %s  \n <hr/>" , count 
				,empno , ename , job , mgr , hiredate , sal , comm , deptno)); */
		
		
		 String table = 
				 "<tr>"
					+"<th>"+empno+"</th>"
					+"<th>"+ename+"</th>"
					+"<th>"+job+"</th>"
					+"<th>"+mgr+"</th>"
					+"<th>"+hiredate+"</th>"
					+"<th>"+sal+"</th>"
					+"<th>"+comm+"</th>"
					+"<th>"+deptno+"</th>"
				+"</tr> ";
				
		out.print(table); 
		out.print("</hr>");
		
		
	}
	out.print("</table>");

	scott.close();

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
</body>
</html>