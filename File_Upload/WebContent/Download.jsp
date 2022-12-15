<%@page import="java.io.*"%>
<%@ page import="utils.JSFunction" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String saveDirectory = application.getRealPath("/Uploads");
	String saveFilename = request.getParameter("sName");
	String originalFilename = request.getParameter("oName");
	
	System.out.println("saveDirectory : " + saveDirectory );
	System.out.println("saveFilename : " + saveFilename);
	System.out.println("originalFilename : " + originalFilename);
	
	try{
		File file = new File(saveDirectory , saveFilename);
		InputStream inStream = new FileInputStream(file);
		
		System.out.println("file : " + file);
		System.out.println("inStream : " + inStream);
		
		// 한글 파일명 깨짐 방지 
		String client = request.getHeader("User-Agent");
		if(client.indexOf("WOW64") == -1){
			originalFilename = new String(originalFilename.getBytes("UTF-8"),"ISO-8859-1");
		}else{
			originalFilename = new String(originalFilename.getBytes("KSC5601") , "ISO-8859-1" );
		}
		
		// 파일 다운로드용 응답 헤더 
		response.reset();
		response.setContentType("application/octet-stream");
		response.setHeader("Content-Disposition" , "attachment; filename=\"" + originalFilename +"\"");
		response.setHeader("Content-Length", "" + file.length());
		
		out.clear();
		OutputStream outStream = response.getOutputStream();
		
		byte b[] = new byte[(int)file.length()];
		int readBuffer = 0;
		while((readBuffer = inStream.read(b)) > 0){
			outStream.write(b , 0 , readBuffer);
		}
		
		inStream.close();
		outStream.close();
		
	}catch(FileNotFoundException e){
		JSFunction.alertBack("파일을 찾을수 없습니다", out);
		e.printStackTrace();
	}catch(Exception e){
		JSFunction.alertBack("오류가 발생했습니다.", out);
		e.printStackTrace();
	}

%>
