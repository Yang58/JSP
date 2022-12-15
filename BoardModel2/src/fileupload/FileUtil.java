package fileupload;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.io.OutputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;

public class FileUtil {
	// 파일 업로드 (multipart/form-data 요청 ) 처리 
	public static MultipartRequest uploadFile(HttpServletRequest request , String saveDirectory, int maxPostSize) {
		try {
			// 파일 업로드 
			return new MultipartRequest(request, saveDirectory , maxPostSize , "UTF-8");
		} catch (Exception e) {
			System.out.println("FileUtil.java : 파일 업로드 실패 ");
			return null;
		}
	}
	
	// 명시한 파일을 찾아 다운로드 
	public static void download(HttpServletRequest request , HttpServletResponse response , String directory ,
			String sfileName , String ofileName) {
		// 서블릿에서 디렉터리의 물리적 경로를 얻어오는 방법 
		String sDirectory = request.getServletContext().getRealPath(directory);
		System.out.println(sDirectory);
		try {
			// 파일을 찾아 입력 스트림 생성
			File file = new File(sDirectory , sfileName);
			InputStream iStream = new FileInputStream(file);
			
			// 한글 깨짐 방지 
			String client = request.getHeader("User-Agent"); // 클라이언트의 웹 브라우저의 종류를 알아옴 
			if(client.indexOf("WOW64") == -1) { // 인터넷 익스플로러일때와 그 외의 경우를 구분 
				ofileName = new String(ofileName.getBytes("UTF-8"), "ISO-8859-1");
			}else {
				ofileName = new String(ofileName.getBytes("KSC5601"), "ISO-8859-1");
			}
			
			// 파일 다운로드 용 헤더 설정 
			response.reset();
			response.setContentType("application/octet-stream");
			response.setHeader("Content-Disposition", "attachment; filename=\"" + ofileName +"\"");
			response.setHeader("Content-Length", "" + file.length());
			
			// ** out.clear() JSP에서는 이 코드가 없으면 예외처리하나 서블릿에서는 오류가 발생하지 않음 
			
			// 새로운 출력 스트림 생성
			OutputStream oStream = response.getOutputStream();  
			
			// 출력 스트림에 파일 내용 출력 
			byte[] b = new byte[(int)file.length()]; 
			int readBuffer = 0;
			while((readBuffer = iStream.read(b)) > 0 ) {
				oStream.write(b,0,readBuffer);
			}
			
			// 입/출력 스트림 닫기
			iStream.close();
			oStream.close();
			
		}catch(FileNotFoundException e) {
			System.out.println("파일을 찾을수 없습니다.");
			e.printStackTrace();
		}catch (Exception e) {
			System.out.println(" download : 파일 다운로드중 예외 발생 ");
			e.printStackTrace();
		}
	}
	
	// 지정한 위치에 파일을 삭제 
	public static void deleteFile(HttpServletRequest request , String directory , String filename) {
		String sDirectory = request.getServletContext().getRealPath(directory);
		// File.separator는 프로그램이 실행 중인 OS에 해당하는 구분자 ( / , \ , . etc... )를 리턴 
		// - 파일의 절대 경로 + 구분자 + 파일 명 --> c:// Uploads / file.exe 
		File file = new File(sDirectory + File.separator + filename); 
		if(file.exists()) {
			file.delete();
		}
	}
	
}
