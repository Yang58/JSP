package mvcboard;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;

import fileupload.FileUtil;
import utils.JSFunction;

@WebServlet("/edit.do")
public class EditController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String idx = request.getParameter("idx");
		MVCBoardDAO dao = new MVCBoardDAO(); // DB 연결 
		MVCBoardDTO dto = dao.selectView(idx); // 일련변호랑 일치하는 게시물 저장 
		request.setAttribute("dto", dto); // request영역에 dto 저장 
		dao.close();
		request.getRequestDispatcher("./Edit.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 1. 파일 업로드 처리 
		String saveDirectory = request.getServletContext().getRealPath("/Uploads"); // 물리적 경로 확인
		
		ServletContext application = getServletContext();
		int maxPostSize = Integer.parseInt(application.getInitParameter("maxPostSize"));
		
		MultipartRequest mr = FileUtil.uploadFile(request, saveDirectory, maxPostSize);
		
		if(mr == null) {
			//파일 업로드 실패
			JSFunction.alertBack(response, "파일이 제한 용량을 초과합니다.");
			return ;
		}
		
		//2. 파일 업로드 외 DB 수정 처리 
		
		String idx = mr.getParameter("idx");
		String prevOfile = mr.getParameter("prevOfile");
		String prevSfile = mr.getParameter("prevSfile");
		
		String name = mr.getParameter("name");
		String title = mr.getParameter("title");
		String content = mr.getParameter("content");
		
		
		// 비밀번호는 Session 영역에서 가져옴 
		HttpSession session = request.getSession();
		String pass = session.getAttribute("pass").toString();
		
		// 수정한 데이터 dto 저장 
		MVCBoardDTO dto = new MVCBoardDTO();
		dto.setIdx(idx);
		dto.setName(name);
		dto.setTitle(title);
		dto.setContent(content);
		dto.setPass(pass);
		
		String fileName = mr.getFilesystemName("ofile");
		if(fileName != null) {
			String now = new SimpleDateFormat("yyyyMMdd_HmsS").format(new Date());
			String ext = fileName.substring(fileName.lastIndexOf("."));
			String newFileName = now + ext ;
			
			File oldFile = new File(saveDirectory + File.separator + fileName);
			File newFile = new File(saveDirectory + File.separator + newFileName);
			oldFile.renameTo(newFile);
			
			dto.setOfile(fileName);
			dto.setSfile(newFileName);
			// 기존 파일 삭제 
			FileUtil.deleteFile(request, "/Uploads", prevSfile);
		}else {
			// 첨부파일이 없다면 기존 파일의 이름 유지 
			dto.setOfile(prevOfile);
			dto.setSfile(prevSfile);
		}
		
		
		// DB에 수정 내용 반영
		MVCBoardDAO dao = new MVCBoardDAO();
		int result = dao.updatePost(dto);
		dao.close();
		
		if(result == 1) {
			// 게시물 수정이 성공하면 기존에 session 영역에 있는 pass 속성을 지우고 idx를 쿼리스트링으로 넘겨 상세보기 서블릿으로 이동 
			session.removeAttribute("pass");
			response.sendRedirect("./view.do?idx=" + idx);
		}else {
			JSFunction.alertLocation(response, "비밀번호 검증을 다시해주세요",  "./view.do?idx=" + idx);
		}
	}

}
