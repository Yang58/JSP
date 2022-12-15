package login_src;

import javax.servlet.jsp.JspWriter;

public class AlertManager {

	
	public static void alertView(String msg , String url , JspWriter out) {
				
		try {
			
			String script = ""
					+ "<script>"
					+ " alert ('" + msg +"' );"
					+ " location.href ='" + url +"';"
					+ "</script>";
			out.print(script);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public static void alertBack(String msg , JspWriter out) {
		try {
			String script = ""
					+ "<script>"
					+ " alert ('" + msg +"' );"
					+ "  history.back();"
					+ "</script>";
			out.print(script);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
}
