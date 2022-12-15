package common;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;


@WebServlet("/write")
public class W_Cotroller extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public W_Cotroller() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String sDirectory = request.getServletContext().getRealPath("/Uploads");
		int maxSize = 1024 * 1000; 
		MultipartRequest mr = FileU.uploadFile(request, sDirectory, maxSize);
		
		if( mr == null) {
			System.out.println("실패");
			return;
		}
		
		DTO dto = new DTO();
		
		dto.setName(mr.getParameter("name"));
		dto.setTitle(mr.getParameter("title"));
		dto.setContent(mr.getParameter("content"));
		dto.setPass(mr.getParameter("pass"));
		
		DAO dao = new DAO();
		int result = dao.insertW(dto);
		
		dao.close();
		String fileName = mr.getFilesystemName("ofile");
		if(fileName != null) {
			
			String now = new SimpleDateFormat("yyyyMMdd_HmsS").format(new Date()); 
			String ext = fileName.substring(fileName.lastIndexOf("."));
			String newFileName = now+ext;
			
			File oldFile = new File(sDirectory , File.separator + fileName);
			File newFile = new File(sDirectory , File.separator + newFileName);
			oldFile.renameTo(newFile);
			
			dto.setOfile(fileName);
			dto.setSfile(newFileName);
			
		}
		if(result == 1) {
			System.out.println("업로드 성공 ");
		}else {
			System.out.println("업로드 실패 ");
		}
	}

}
