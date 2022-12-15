package utils;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CookieManager {
	
	
	// 매개변수로 쿠키 이름 , 값 , 시간을 받아 쿠키 생성
	public static void makeCookie(HttpServletResponse response , String cName, String cValue , int cTime) {
		Cookie cookie = new Cookie(cName,cValue);
		cookie.setPath("/");
		cookie.setMaxAge(cTime);
		response.addCookie(cookie);
	}
	
	
	// 쿠키 이름을 받아 쿠키에서 검색 후 값을 반환 
	public static String readCookie(HttpServletRequest request , String cName) {
		
		String cookieValue =""; // 반환 값을 받을 변수 
		
		Cookie[] cookies = request.getCookies();
		if(cookies != null) {
			for(Cookie c : cookies) {
				String cookieName = c.getName();
				if(cookieName.equals(cName)) {
					cookieValue = c.getValue();
				}
			}
		}
		return cookieValue;
	}
	
	
	// 쿠키 삭제 
	public static void deleteCookie(HttpServletResponse response, String cName) {
		makeCookie(response,cName ,"",0); // 쿠키의 값과 시간을 초기화 
	}
}
