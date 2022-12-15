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

import com.oreilly.servlet.MultipartRequest;

import fileupload.FileUtil;
import utils.JSFunction;

/**
 * Servlet implementation class WirteController
 */
@WebServlet("/write.do")
public class WriteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public WriteController() {
        super();
    }
    
    @Override
    protected void doGet(HttpServletRequest request , HttpServletResponse response) throws ServletException , IOException{
    	request.getRequestDispatcher("./Write.jsp").forward(request, response);
    }

    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1 파일 업로드 처리 
		
		// 업로드 디렉토리의 물리적 경로 확인 
		String saveDirectory = request.getServletContext().getRealPath("/Uploads");
		// 파일 최대 용량 확인
		// int maxPostSize = 1024 * 1000 ; 
		ServletContext application = getServletContext();
		int maxPostSize = Integer.parseInt(application.getInitParameter("maxPostSize"));
		
		//파일 업로드 FileUtil.java 사용 
		MultipartRequest mr = FileUtil.uploadFile(request, saveDirectory, maxPostSize);
		if(mr == null) {
			// 파일 업로드 실패 
			JSFunction.alertLocation(response, "첨부 파일이 제한 용량을 초과합니다 " , "./write.do");
			return;
		}
		
		// 2 파일 업로드 외 처리 
		// WriteFrm 의 Form 값을 DTO에 저장 
		MVCBoardDTO dto = new MVCBoardDTO();
	
		dto.setName(mr.getParameter("name"));
		dto.setTitle(mr.getParameter("title"));
		dto.setContent(mr.getParameter("content"));
		dto.setPass(mr.getParameter("pass"));
		
		// 원본 파일 명과 저장된 파일 이름 설정 
		String fileName = mr.getFilesystemName("ofile");
		if(fileName != null) {
			// 파일이 있을 경우 파일명 변경 
			String now = new SimpleDateFormat("yyyyMMdd_HmsS").format(new Date()); 
			String ext = fileName.substring(fileName.lastIndexOf("."));
			String newFileName = now+ext; // 서버에 저장될 새로운 파일명 생성 
			
			File oldFile = new File(saveDirectory , File.separator + fileName); // 기존 파일명 
			File newFile = new File(saveDirectory , File.separator + newFileName); // 새로운 파일명 
			oldFile.renameTo(newFile);
			
			dto.setOfile(fileName);
			dto.setSfile(newFileName);
		}

		
		MVCBoardDAO dao = new MVCBoardDAO();
		int result = dao.insertWrite(dto);
		dao.close();
		
		if(result == 1) {
			response.sendRedirect("./list.do");
		}else {
			response.sendRedirect("./write.do");
			
		}
		
		
	}
}
