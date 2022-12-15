package utils;

public class BoardPage {

	
	public static String pagingStr( int totalCount , int pageSize , int blockPage, int pageNum , String url) {
		String pagingStr = "";
		
		int totalPage = (int)(Math.ceil((double) totalCount / pageSize));
		int pageTemp = (((pageNum - 1 ) / blockPage ) * blockPage) +1 ;
		
		if(pageTemp != 1) {
			pagingStr += "<a href= '" + url + "?pageNum=1'> [첫 페이지] </a>";
			pagingStr += "&nbsp;";
			pagingStr += "<a href = '" + url + "?pageNum=" + (pageTemp -1) + "' > [이전 블록] </a>"; 
		}
		
		int blockCount = 1;
		while(blockCount <= blockPage && pageTemp <= totalPage) {
			if(pageTemp == pageNum) {
				pagingStr += "&nbsp;" + pageTemp + "&nbsp;";
			}else {
				pagingStr += "&nbsp; <a href='" + url + "?pageNum=" +pageTemp+ "'>" + pageTemp +"</a> &nbsp;";  
			}
			pageTemp++;
			blockCount++;
		}
		
		if(pageTemp <= totalPage) {
			pagingStr += "&nbsp; <a href='" + url + "?pageNum=" +pageTemp+"'>[다음 블록]</a> &nbsp;";  
			pagingStr += "&nbsp;";
			pagingStr += "<a href = '" + url + "?pageNum=" + totalPage + "' > [마지막 페이지] </a>"; 
		}
		return pagingStr;
	}
}
