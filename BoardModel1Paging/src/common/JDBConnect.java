package common;

import java.sql.*;
import javax.servlet.ServletContext;

public class JDBConnect {

	public Connection conn;
	public Statement stmt ;
	public PreparedStatement psmt;
	public ResultSet rs;
	
	// 매개변수를 받아 연결
	public JDBConnect(String driver , String url , String id , String pwd)	{
		System.out.println(driver);
		System.out.println(url);
		System.out.println(id);
		System.out.println(pwd);
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
		try { 
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
