package model2.mvcboard;

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


@WebServlet("/list.do") 
public class ListControler extends HttpServlet { // list.do라는 요청을 통해 호출받아 동작하여 그 요청을 처리하는 서블릿(컨트롤러)
   private static final long serialVersionUID = 1L;
       
    public ListControler() {
        super();

    }

   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      MVCBoardDAO dao = new MVCBoardDAO();  //DB 연동을 위해 형성
      
      Map<String,Object> map = new HashMap<>(); //검색하기에 대한 요청을 위해 생성
      
      String searchField = request.getParameter("searchField");
      String searchWord = request.getParameter("searchWord");  // 검색하기로 요청 시 전달되는 파라메터들

      if(searchWord != null) { //  검색하기로 요청이 왔는지를 판단하는 구문 (검색하는 단어가 존재할 시 실행문 실행)
         map.put("searchField", searchField);
         map.put("searchWord", searchWord);
      }
      
      int totalCount = dao.selectCount(map); // 검색어가 포함된 전체 게시물 or 모든 전체 게시물 찾아줌  
      
      //페이징
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
      map.put("start", start);
      map.put("end", end);
      
      List<MVCBoardDTO> boardLists = dao.selectListPage(map);
      dao.close();
      
      String pagingImg = BoardPage.pagingStr(totalCount, pageSize, blockPage, pageNum, "./list.do");
      map.put("pagingImg", pagingImg);
      map.put("totalCount", totalCount);
      map.put("pageSize", pageSize);
      map.put("pageNum", pageNum);
      
      request.setAttribute("boardLists", boardLists);
      request.setAttribute("map", map);
      request.getRequestDispatcher("./List.jsp").forward(request, response);
   }

}