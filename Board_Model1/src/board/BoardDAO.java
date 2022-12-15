package board;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import common.JDBConnect;
public class BoardDAO extends JDBConnect{

	public BoardDAO(ServletContext application) { // DB연결
		super(application);
	}
	
	// 검색 조건 중 조건 에 맞는 게시글 수 리턴 
	// DB에 저장되어있는 게시물 수 리턴  
	public int selectCount(Map<String, Object> map) {
		int totalCount = 0 ;
		
		String sql = "select count(*) from board";
		if(map.get("serachWord")!=null) {
			// 매개변수로 받아온 map.get(word)의 값이 있다면 sql에 조건식을 넣어 sql 구문 실행 
			sql += "WHERE" + map.get("searchField")+ " " + " LIKE '%"+map.get("searchWord") + "%'";
		}
		try {
			
			stmt = conn.createStatement(); // 정적 쿼리문 준비 
			rs = stmt.executeQuery(sql); // 정적 쿼리문 실행 
			rs.next(); // rs를 통해 커서를 최초 행으로 이동시킴 
			totalCount = rs.getInt(1);  // 쿼리문의 반환 값이 int형이기 때문에 getInt를 사용해 데이터 저장
			System.out.println("CountList SQL구문 : " + sql );
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("게시물 수를 구하는 중 ... 예외 발생 ");
			e.printStackTrace();
		}
		// 검색한 단어가 있다면 검색한 단어를 포함한 게시글의 총 개수가 리턴 
		// 그렇지 않다면 DB에 저장되어있는 총 개시글의 개수가 리턴 
		return totalCount;
	}
	
	// 검색 조건에 맞는 게시글을 리턴 
	public List<BoardDTO> selectList(Map<String , Object> map){
		List<BoardDTO> bbs = new ArrayList<>(); // 테이블의 모든 레코드를 저장할수 있는 DTO객체로 LIst생성 
		
		String sql = "select * from board"; // 필요한 select 구문 작성 
		if(map.get("searchWord") != null) {
			// form에서 제목과 내용의 value 값으로 where 조건을 설정 후 input에 작성한 내용으로 검색 
			sql +=" where " + map.get("searchField") + " " + "like '%" + map.get("searchWord")+"%'";
		}
		sql += " order by num desc";
		System.out.println("SelectList SQL구문 : " + sql );
		
		try {
			stmt = conn.createStatement(); // 정적 쿼리문 준비 
			rs = stmt.executeQuery(sql); // select 구문 실행 
			
			while(rs.next()) { // sql 실행시 출력되는 레코드의 개수만큼 반복 
				BoardDTO dto = new BoardDTO(); // 테이블의 모든 레코드를 저장할수있는 DTO객체 생성 
				 
				// 하나씩 값을 받아 dto 객체에 저장 
				dto.setNum(rs.getString("num"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setDate(rs.getDate("postdate"));
				dto.setId(rs.getString("id"));
				dto.setVisitcount(rs.getString("visitcount"));
				
				// 모든 값을 받은 dto객체를 list에 저장 
				bbs.add(dto);
				
			}
		} catch (Exception e) {
			System.out.println("게시글 조회 중 오류 발생 ");
			e.printStackTrace();
		}
		// 모든 게시글을 저장하고있는 list 리턴 
		return bbs;
	}
	
		// 페이징 기능을 수행 할수 있는 메소드  
		public List<BoardDTO> selectListPage(Map<String , Object> map){
			List<BoardDTO> bbs = new ArrayList<>(); // 테이블의 모든 레코드를 저장할수 있는 DTO객체로 LIst생성 
			
			String sql = "select * from ( select tb.* , rownum rnum from ( select * from board ";
			
			// 검색 조건 
			if(map.get("searchWord") != null) {
				sql += " where " + map.get("searchField") + " like '%" + map.get("searchWord") +"%' ";
			}
			sql += " order by num desc ) tb ) where rnum between ? and ?";
				
			System.out.println("List SQL구문 : " + sql );
			
			try {
				psmt = conn.prepareStatement(sql); 
				psmt.setString(1, map.get("start").toString()); // 한 페이지에 보여줄 게시글의 시작 번호 
				psmt.setString(2, map.get("end").toString()); 	// 한 페이지에 보여줄 게시글의 끝 번호 
				System.out.println("Start : " + map.get("start") + " / " + "end : " + map.get("end"));
				
				rs = psmt.executeQuery();
				
				while(rs.next()) { // 테이블의 레코드를 하나씩 돌며 DB에서 데이터를 얻어온후 그 데이터를 DTO객체에 저장 
								   //    		-> 그 후 dto객체를 Arraylist[index]에 저장 
					BoardDTO dto = new BoardDTO();
					
					dto.setNum(rs.getString("num"));
					dto.setTitle(rs.getString("title"));
					dto.setContent(rs.getString("content"));
					dto.setDate(rs.getDate("postdate"));
					dto.setId(rs.getString("id"));
					dto.setVisitcount(rs.getString("visitcount"));
					
					bbs.add(dto);
					
				}
			} catch (Exception e) {
				System.out.println("게시글 조회 중 오류 발생 ");
				e.printStackTrace();
			}
			return bbs;
		}
	// 게시글 저장 
	public int insertWrite(BoardDTO dto) {
		int result = 0;
		
		try {
			
			String sql = "insert into board ( " + " num , title , content , id , visitcount) " 
							+ " values ( " + " seq_board_num.nextval, ? , ? , ? , 0)";
			System.out.println("insert sql : " + sql );
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getContent());
			psmt.setString(3, dto.getId());
			
			result = psmt.executeUpdate(); // 쿼리문이 업데이트 된 수 리턴 Int형 반환  
			
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("게시글 업데이트 중 오류 발생 ");
			e.printStackTrace();
		}
		
		return result;
	}
	
	// 번호를 받아 번호랑 같은 게시글 가져오기 
	public BoardDTO selectView(String num) {
		BoardDTO dto = new BoardDTO();
		
		String sql = "select B.* , M.name "
				+ " from member M inner join board B "
				+ " on m.id=b.id"
				+ " where num=?";
		System.out.println("VIEW SQL : " +sql);
		
		try {
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, num);
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				dto.setNum(rs.getString(1));
				dto.setTitle(rs.getString(2));
				dto.setContent(rs.getString("content"));
				dto.setDate(rs.getDate("postdate"));
				dto.setId(rs.getString("id"));
				dto.setVisitcount(rs.getString("visitcount"));
				dto.setName(rs.getString("name"));
			}
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("상세보기중 오류 발생 ");
			e.printStackTrace();
		}
		
		System.out.println(dto);
		return dto;
	}
	
	
	// 방문자 수 증가 쿼리 메소드  
	public void updateVisitCount(String num) {
		System.out.println("num" + num );
		String sql = "update board set "
					+ " visitcount = visitcount +1 "
					+" where num = ?";
		
		System.out.println("Update SQL : " + sql);
		try {
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, num);
			rs = psmt.executeQuery();
			System.out.println("방문자 수 증가 완료");
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
	}
	
	//게시글 수정 하기 
	public int updateEdit(BoardDTO dto) {
		int result = 0 ;
		
		try {
			String sql = "update board set title=? , content=? where num=?";
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getContent());
			psmt.setString(3, dto.getNum());
			
			result = psmt.executeUpdate();
			
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("게시글 수정 중 오류 발생 ");
		}
		return result;
	}
	
	
	//게시글 삭제 메서드 
	public int deletePost(BoardDTO dto) {
		int result = 0 ;
		try {
			String sql = "delete from board where num=?";
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getNum());
			result = psmt.executeUpdate();
			System.out.println("Delete SQL 정상 실행 : " + sql);
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			System.out.println("게시글을 삭제 하는 중 오류 발생 ");
		}
		System.out.println("Delete Result : " + result);
		return result;
		
	}
	
	
}
