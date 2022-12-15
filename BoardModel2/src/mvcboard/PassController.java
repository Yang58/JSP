package mvcboard;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import fileupload.FileUtil;
import utils.JSFunction;

/**
 * Servlet implementation class PassController
 */
@WebServlet("/pass.do")
public class PassController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public PassController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// pass.do?mode=edit & idx=6 
		// View.jsp 에서 쿼리스트링으로 넘긴 데이터를 받아옴 
		request.setAttribute("mode", request.getParameter("mode"));
		request.getRequestDispatcher("./Pass.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// Pass.jsp 에서 전송한 form 값 받기 (post방식으로 넘겼기 때문에 doPost에서 처리 ) 
		String idx = request.getParameter("idx");
		String mode = request.getParameter("mode");
		String pass = request.getParameter("pass");
		
		MVCBoardDAO dao = new MVCBoardDAO(); 
		boolean confirmed = dao.confirmPassword(pass, idx);
		dao.close();
		
		if(confirmed) {
			// mode를 확인 ( 수정인지 삭제인지 )
			if(mode.equals("edit")) { // 수정하기
				HttpSession session = request.getSession();
				session.setAttribute("pass", pass);
				response.sendRedirect("./edit.do?idx=" + idx );
			}
			else if(mode.equals("delete")) { // 삭제 하기 
				/* 현재 요청이 삭제라면 게시물에 첨부된 파일도 삭제해야함 게시물을 삭제하기전에
				 	기존 정보를 보관 후 삭제 후에 보관해둔 정보에서 파일 이름을 찾아 첨부 파일까지 마저 삭제 */
				dao = new MVCBoardDAO();
				MVCBoardDTO dto = dao.selectView(idx); // 기존 정보 저장 
				int result = dao.deletePost(idx);
				dao.close();
				
				if(result == 1) {
					// 삭제 성공 ( 첨부 파일도 삭제 ) 
					String saveFileName = dto.getSfile(); // 서버에 저장된 파일의 이름을 가져옴 
					FileUtil.deleteFile(request, "/Uploads", saveFileName);
					
				}
				JSFunction.alertLocation(response, "삭제되었습니다.", "./list.do");
			}
		}else {
			// 비밀번호 불일치 
			JSFunction.alertBack(response, "비밀번호 검증에 실패했습니다");
		}
	}
}
