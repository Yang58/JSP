package mvcboard;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/view.do")
public class ViewController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	
	// service 는 get post 방식을 둘다 지원 
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//DB 연결
		MVCBoardDAO dao = new MVCBoardDAO();
		
		// list.jsp 에서 제목(링크) 클릭시 쿼리스트링으로 idx를 보냄  
		String idx = request.getParameter("idx"); // 게시물의 idx번호를 받아옴 
		dao.updateVisitCount(idx); // 조회수 증가 메서드 실행
		MVCBoardDTO dto = dao.selectView(idx); // 상세보기 메서드 
		dao.close();
		
		// 줄바꿈 
		dto.setContent(dto.getContent().replace("\r\n", "<br/>"));
		
		// 게시물 저장 후 뷰로 포워드 
		request.setAttribute("dto", dto);
		request.getRequestDispatcher("./View.jsp").forward(request, response);
	}


}
