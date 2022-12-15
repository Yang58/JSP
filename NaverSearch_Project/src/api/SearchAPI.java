package api;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/NaverSearchAPI.do")
public class SearchAPI extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public SearchAPI() {
        super();
        // TODO Auto-generated constructor stub
    }

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	// 본인 인증 정보 설정 
        String clientId = "yvKJuk6k3eIwT6LA8bde"; 	// API 클라이언트 아이디
        String clientSecret = "3GIWbk290m"; 		// API 클라이언트 시크릿

        
        
        // 검색 조건 설정 
        int startNum = 0; // 검색 시작 위치 
        String text = null; // 검색어 
        try {
        	startNum = Integer.parseInt(req.getParameter("startNum"));
        	String searchText = req.getParameter("keyword");
            text = URLEncoder.encode(searchText, "UTF-8"); // 검색어 한글 깨짐을 방지하기위해 인코딩 
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException("검색어 인코딩 실패",e);
        }

        
        
        // API URL 조합 
        //String apiURL = "https://openapi.naver.com/v1/search/blog.xml?query="+ text; // XML 결과
        // 검색 결과 데이터를 JSON 으로 받기위한 API , 검색으를 쿼리스트링으로 보내며 display와 start 매개변수도 추가 
        // display는 한번에 가져올 검색 결과의 개수이며 , start는 검색 시작 위치 
        String apiURL = "https://openapi.naver.com/v1/search/blog?query=" 
        + text + "&display=10&start=" + startNum;    // JSON 결과

        // API 호출 : 클라이언트 아이디와 시크릿을 요청헤더로 전달해 API 호출 
        Map<String, String> requestHeaders = new HashMap<>();
        requestHeaders.put("X-Naver-Client-Id", clientId);
        requestHeaders.put("X-Naver-Client-Secret", clientSecret);
        String responseBody = get(apiURL,requestHeaders);

        // 결과 출력 : 검색 결과를 콘솔에 출력 , 서블릿에서도 즉시 출력하기위해 콘텐츠 타입을 설정한 후 write() 메서드 호출 
        System.out.println(responseBody);
        
        resp.setContentType("text/html;charset=UTF-8");
        resp.getWriter().write(responseBody); // 서블릿에서 즉시 출력 
        
    }
    
    private static String get(String apiUrl, Map<String, String> requestHeaders){
        HttpURLConnection con = connect(apiUrl);
        try {
            con.setRequestMethod("GET");
            for(Map.Entry<String, String> header :requestHeaders.entrySet()) {
                con.setRequestProperty(header.getKey(), header.getValue());
            }


            int responseCode = con.getResponseCode();
            if (responseCode == HttpURLConnection.HTTP_OK) { // 정상 호출
                return readBody(con.getInputStream());
            } else { // 오류 발생
                return readBody(con.getErrorStream());
            }
        } catch (IOException e) {
            throw new RuntimeException("API 요청과 응답 실패", e);
        } finally {
            con.disconnect();
        }
    }


    private static HttpURLConnection connect(String apiUrl){
        try {
            URL url = new URL(apiUrl);
            return (HttpURLConnection)url.openConnection();
        } catch (MalformedURLException e) {
            throw new RuntimeException("API URL이 잘못되었습니다. : " + apiUrl, e);
        } catch (IOException e) {
            throw new RuntimeException("연결이 실패했습니다. : " + apiUrl, e);
        }
    }


    private static String readBody(InputStream body){
        InputStreamReader streamReader = new InputStreamReader(body);


        try (BufferedReader lineReader = new BufferedReader(streamReader)) {
            StringBuilder responseBody = new StringBuilder();


            String line;
            while ((line = lineReader.readLine()) != null) {
                responseBody.append(line);
            }


            return responseBody.toString();
        } catch (IOException e) {
            throw new RuntimeException("API 응답을 읽는 데 실패했습니다.", e);
        }
    }
}
