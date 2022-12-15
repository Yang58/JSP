package utils;

public class BoardPage {
	//								총 게시글 수 ,  한페이지에 보일 게시글 수 , 목록에 보일 페이지 개수 , 현재 보고있는 블록 넘버 , 이동 url 
	public static String pagingStr(int totalCount , int pageSize , int blockPage , int pageNum , String reqUrl) {
		System.out.println("totalCount : " + totalCount);
		System.out.println("pageSize : " + pageSize);
		System.out.println("blockPage : " + blockPage);
		System.out.println("PageNum : " + pageNum );
		System.out.println("reqUrl : " + reqUrl);
		String pagingStr = "";
		// 전체 페이지 수 계산 실수형으로 계산 후 반올림 
		int totalPages = (int) (Math.ceil(((double) totalCount / pageSize)));
		
		// 이전 페이지 블록 바로가기 출력 
		int pageTemp = (((pageNum -1) / blockPage) * blockPage) +1;
		if(pageTemp != 1) { // 현재 가르키는 페이지가 1번째 페이지가 아니라면  즉 , 1~11번 페이지중 1번째 페이지 제외 나머지 페이지 실행 
			pagingStr += "<a href='" + reqUrl +"?pageNum=1'> [첫 페이지] </a>";
			pagingStr += "&nbsp;";
			pagingStr += "<a href='" + reqUrl +"?pageNum=" + (pageTemp -1) +"'> [이전 블록] </a>";
		}
		
		// 각 페이지 번호 출력 
		int blockCount = 1;
		while(blockCount <= blockPage && pageTemp <= totalPages) {
			if(pageTemp == pageNum) {
				// 현재 페이지에는 링크를 걸지 않음
				pagingStr += "&nbsp;" + pageTemp + "&nbsp;";
			}else {
				// 쿼리 스트링으로 현재 페이지의 값을 List.jsp 로 보냄 
				pagingStr += "&nbsp; <a href='" + reqUrl + "?pageNum=" + pageTemp + "'> " + pageTemp + "</a> &nbsp;";
			}
			pageTemp++;
			blockCount++;
		}
		
		
		if(pageTemp <= totalPages) {
			pagingStr += "<a href='" + reqUrl +"?pageNum=" + pageTemp +"'> [다음 블록] </a>";
			pagingStr += "&nbsp;";
			pagingStr += "<a href='" + reqUrl +"?pageNum=" + totalPages +"'> [마지막 페이지]</a>";
		}
		
		return pagingStr;
	}
}
