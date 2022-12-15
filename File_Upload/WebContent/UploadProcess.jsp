<%@page import="java.io.File"%>
<%@page import="java.util.*"%>
<%@page import="fileupload.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String saveDirectory = application.getRealPath("/Uploads"); // 저장할 디렉토리 설정 
	int maxPostSize = 1024 * 1000; // 파일 최대 크기 설정 (1MB)
	String encoding = "UTF-8"; // 인코딩 방식 설정 
	
	try{
		// 확장 라이브러리 객체 생성 
		MultipartRequest mr = new MultipartRequest(request , saveDirectory , maxPostSize , encoding); 
		
		String fileName = mr.getFilesystemName("attachedFile"); //현재 파일 이름 

		// 서버에 저장될 파일 이름 설정 
		String ext = fileName.substring(fileName.lastIndexOf(".")); // 글자 커팅 ( 확장자명 전까지 ) 
		String now = new SimpleDateFormat("yyyyMMdd_HmsS").format(new Date());
		String newFileName = now + ext ; 
		File oldFile = new File(saveDirectory + File.separator + fileName);
		File newFile = new File(saveDirectory + File.separator + newFileName);
		oldFile.renameTo(newFile); //현재 파일이름을 서버에 저장될 파일이름으로 변경 

		// 폼값 받기 
		String name = mr.getParameter("name");
		String title = mr.getParameter("title");
		String cateArray[] = mr.getParameterValues("cate");
		StringBuffer cateBuf = new StringBuffer();

		
		if(cateArray == null){
			cateBuf.append("선택 없음 ");
		}
		else{
			for (String s : cateArray){
				cateBuf.append(s + " ");
			}
		}
		//DTO 생성  
		MyfileDTO dto = new MyfileDTO();
		dto.setName(name);
		dto.setTitle(title);
		dto.setCate(cateBuf.toString());
		dto.setOfile(fileName);
		dto.setSfile(newFileName);
		
		
		MyfileDAO dao = new MyfileDAO(application);
		dao.insertFile(dto);
		dao.close();

		response.sendRedirect("FileList.jsp");

	}catch(Exception e){
		System.out.println("UploadProcess.java 파일 검사중 오류 발생");
		e.printStackTrace();
		request.getRequestDispatcher("FileUploadMain.jsp").forward(request,response);
	}
%>