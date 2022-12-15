package common;

import java.sql.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class DBConnPool {
	public Connection con;
	
	public DBConnPool() {
		try {
			Context initCtx = new InitialContext();
			Context ctx = (Context) initCtx.lookup("java:comp/env");
			
			DataSource source = (DataSource)ctx.lookup("dbcp_myoracle"); // server.xml에서 정의한 name 속성 값을 지정  
			con = source.getConnection();
			System.out.println("ctx : " + ctx +"\n"+"connection : "+ con +" \nSource : " + source );
			} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	
	public void close()	{
		try {
			if(con != null) {
				con.close();
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
}
