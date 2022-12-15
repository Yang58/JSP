package common;

import java.beans.Statement;
import java.sql.*;
import javax.servlet.ServletContext;

public class JDBConnect {

	public Connection conn = null;
	public Statement stmt ;
	public PreparedStatement psmt;
	public ResultSet rs;
	
	
	// 값을 지정해서 연결 
	public JDBConnect()	{
		String url = "jdbc:oracle:thin:@localhost:1521:orcl"; 
		try{
			Class.forName("oracle.jdbc.driver.OracleDriver"); // Oracle Class가 있는지 확인 
			conn = DriverManager.getConnection(url, "musthave" , "1234");// (DB 주소 , DB계정  , DB비빌번호)
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	// 매개변수를 받아 연결
	public JDBConnect(String driver , String url , String id , String pwd)	{
		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url , id , pwd);
			System.out.println("DB 연결 성공 (인수 생성자)");
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public JDBConnect(ServletContext application) {
		try {
			String driver = application.getInitParameter("OracleDriver");
			Class.forName(driver);
			String url = application.getInitParameter("OracleUrl");
			String id = application.getInitParameter("OracleId");
			String pwd =application.getInitParameter("OraclePwd");
			
			System.out.println("DB 연결 성공 (. xml 초기화 방식)");
			conn = DriverManager.getConnection(url,id,pwd);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	
	public void close() {
		try { // 닫아줘야 하는 순서  (rs 먼저 , conn 제일 마지막 // stmt , psmt 는 닫는 순서 중요하지 않음  ) 
			if(rs != null) {
				System.out.println("rs 연결 해제");
				conn.close();
			}
			if(stmt != null) {
				System.out.println("stmt 연결 해제");
				conn.close();
			}
			if(psmt != null) {
				System.out.println("psmt 연결 해제");
				conn.close();
			}
			if(conn != null) {
				System.out.println("conn 연결 해제");
				conn.close();
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
}
