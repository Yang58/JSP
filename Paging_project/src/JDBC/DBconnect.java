package JDBC;

import java.sql.*;
import javax.servlet.ServletContext;

public class DBconnect {
	public Connection con;
	public Statement stmt;
	public PreparedStatement psmt;
	public ResultSet rs;
	
	public DBconnect(ServletContext application) {
		
		try {
			String driver = application.getInitParameter("OracleDriver");
			Class.forName(driver);
			String url = application.getInitParameter("OracleUrl");
			String id = application.getInitParameter("OracleId");
			String pwd =application.getInitParameter("OraclePwd");
			
			con = DriverManager.getConnection(url, id, pwd);
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void close() {
		try { 
			if(rs != null) {
				System.out.println("rs 연결 해제");
				rs.close();
			}
			if(stmt != null) {
				System.out.println("stmt 연결 해제");
				stmt.close();
			}
			if(psmt != null) {
				System.out.println("psmt 연결 해제");
				psmt.close();
			}
			if(con != null) {
				System.out.println("conn 연결 해제");
				con.close();
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
}
