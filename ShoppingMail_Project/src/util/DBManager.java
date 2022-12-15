package util;

import javax.sql.*;
import java.sql.*;
import javax.naming.*;

public class DBManager {
	
	public static Connection getConnection()	{
		
		Connection conn = null;
		
		try{
			Context init = new InitialContext();
			DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/myoracle");
			conn = ds.getConnection();
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return conn;
	}
	
	public static void close(Connection conn , PreparedStatement psmt , ResultSet rs) {
		// sql 구문을 사용할떄의 close
		if(rs != null) {
			try {
				rs.close();
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		if(psmt != null) {
			try {
				psmt.close();
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		if(conn != null) {
			try {
				conn.close();
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	public static void close(Connection conn , PreparedStatement psmt ) {
		// insert , delete , update 구문일떄 close
		if(psmt != null) {
			try {
				psmt.close();
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		if(conn != null) {
			try {
				conn.close();
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
	}
}
