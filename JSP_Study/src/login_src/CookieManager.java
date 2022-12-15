package login_src;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CookieManager {
	// 쿠키 생성 
	public static void MakeCookie(HttpServletResponse response , String cName , String cValue , int cTime) { 
		Cookie c = new Cookie(cName , cValue);
		c.setPath("/");
		c.setMaxAge(60);
		response.addCookie(c);
	}
	
	// 쿠키의 이름을 받아 쿠키 값 반환 
	public static String readCookie(HttpServletRequest request , String cName ) {
		
		String returnCookie = "";
		
		Cookie[] cookies = request.getCookies();
		if(cookies != null) {
			for(Cookie s : cookies) {
				String cooName = s.getName();
				String cooValue = s.getValue();
				
				if(cooName.equals(cName)) {
					returnCookie = cooValue;
				}
			}
		}
		
		return returnCookie;
		
	}
	
	// MakeCookie 를 이용해 쿠키 삭제 
	public static void DeleteCookie(HttpServletResponse response , String cName) {
		MakeCookie(response , cName , "" , 0);
	}

}
