package mvcboard;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import utils.BoardPage;


@WebServlet("/list.do")  // 매핑 과정 
public class ListController extends HttpServlet { 
	// list.do로 매핑 -> list.do라는 요청이 들어오면 ListController 서블릿에서 처리 (컨트롤러)
   private static final long serialVersionUID = 1L;
       
    public ListController() {
        super();
    }

   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	   
	  /*List.jsp 에서 필요한 정보 
	   * 1. title과 content로 검색 기능 -> List.jsp 에서 get방식으로 데이터 처리 url은 자기 자신 
	   * 2. 번호 , 제목 , 작성자 ,조회수 , 작성일 , 첨부파일 등등 모든 DB정보를 담은 List컬렉션
	   * 3. 페이징 기능	 
	   * 4. 글쓰기로 이동
	   */		
	  
      MVCBoardDAO dao = new MVCBoardDAO();  //DB 연동
      
      Map<String,Object> map = new HashMap<>(); //검색하기에 대한 요청을 위해 생성
      
      // 쿼리스트링으로 보낸 데이터를 변수에 담아 저장 ( Ex. searchField=title & searchWord=10 ) 
      String searchField = request.getParameter("searchField");
      String searchWord = request.getParameter("searchWord");  
      

      if(searchWord != null) { //  검색하기로 요청이 왔는지를 판단하는 구문 (검색하는 단어가 존재할 시 실행문 실행 )
         map.put("searchField", searchField);
         map.put("searchWord", searchWord);
      }
      
      // DB와 연결되서 데이터 처리를 해야할 경우는 DAO에 작성후 메서드 호출 
      // 검색어가 포함된 전체 게시물 or 모든 전체 게시물 개수 리턴  
      int totalCount = dao.selectCount(map); 
      
      //페이징 기능 
      // 서블릿에서 application 객체에 접근하는 방식 
      ServletContext application = getServletContext(); 
      int pageSize = Integer.parseInt(application.getInitParameter("POSTS_PER_PAGE"));
      int blockPage = Integer.parseInt(application.getInitParameter("PAGES_PER_BLOCK"));
      
      int pageNum = 1;
      String pageTemp = request.getParameter("pageNum");
      if(pageTemp != null && !pageTemp.equals("")) {
         pageNum = Integer.parseInt(pageTemp);
      }
      
      int start = (pageNum -1) * pageSize + 1;
      int end = pageNum * pageSize;
      // 페이징에 필요한 값을 map에 저장 
      map.put("start", start);
      map.put("end", end);
      List<MVCBoardDTO> boardLists = dao.selectlistpaging(map);
      dao.close(); // 사용한 DB는 반드시 닫아줘야함 
      
      
      // 페이지 번호를 출력하기위한 파라미터를 담아 메서드 실행  
      // pagingStr은 return이 Html언어로 구성된 String형 문자열 리턴 
      String pagingImg = BoardPage.pagingStr(totalCount, pageSize, blockPage, pageNum, "./list.do"); 
      // 뷰에서도 사용해야하기 때문에 Map에 저장 
      map.put("pagingImg", pagingImg);
      map.put("totalCount", totalCount);
      map.put("pageSize", pageSize);
      map.put("pageNum", pageNum);
      
      // request 영역에 데이터 저장 
      request.setAttribute("boardLists", boardLists); // boardLists는 sql에서 rownum으로 정렬된 게시물들을 담은 컬렉션 
      request.setAttribute("map", map); // 필요한 데이터를 담은 map컬렉션 
      // 서블릿에서는 뷰 기능이 없기 때문에 뷰에서 필요한 데이터를 서블릿에서 수집해 모든 데이터를 뷰로 넘겨준다. 
      request.getRequestDispatcher("./List.jsp").forward(request, response); 
   }

}