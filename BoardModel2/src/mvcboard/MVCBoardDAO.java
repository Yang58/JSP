package mvcboard;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import common.DBConnPool;

public class MVCBoardDAO extends DBConnPool{

	public MVCBoardDAO() {
		super();
	}
	
	public int selectCount(Map<String, Object> map) {
		int totalCount = 0 ;
		
		String sql = "select count(*) from mvcboard ";
		if(map.get("serachWord") != null) {
			// 찾는 단어가 없다면 조건을 추가하여 DB데이터 검색 
			sql += "WHERE" + map.get("searchField")+ " " + " LIKE '%"+map.get("searchWord") + "%'";
		}
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			rs.next();
			totalCount = rs.getInt(1);
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(" selectCount : 예외 발생 ");
			e.printStackTrace();
		}
		return totalCount;
	}
	
	public List<MVCBoardDTO> selectlistpaging(Map<String , Object> map){
		List<MVCBoardDTO> bbs = new ArrayList<>();
		
		String sql = "select * from ( select tb.* , rownum rnum from ( select * from mvcboard ";
		
		// 검색 조건 
		if(map.get("searchWord") != null) {
			sql += " where " + map.get("searchField") + " like '%" + map.get("searchWord") +"%' ";
		}
		sql += " order by idx desc ) tb ) where rnum between ? and ?";
			
		try {
			psmt = con.prepareStatement(sql);
			// LIst.jsp 에서 매개변수로 넘겨준 start 와 end 데이터의 키값을 이용해 value 값을 받아 쿼리문에 삽입 
			psmt.setString(1, map.get("start").toString()); 
			psmt.setString(2, map.get("end").toString());
			rs = psmt.executeQuery();
			
			while(rs.next()) { // 테이블의 레코드를 하나씩 돌며 DB에서 데이터를 얻어온후 그 데이터를 DTO객체에 저장 
							   //    		-> 그 후 dto객체를 Arraylist[index]에 저장 
				MVCBoardDTO dto = new MVCBoardDTO();
				
				dto.setIdx(rs.getString(1));
				dto.setName(rs.getString(2));
				dto.setTitle(rs.getString(3));
				dto.setContent(rs.getString(4));
				dto.setPostdate(rs.getDate(5));
				dto.setOfile(rs.getString(6));
				dto.setSfile(rs.getString(7));
				dto.setDowncount(rs.getInt(8));
				dto.setPass(rs.getString(9));
				dto.setVisitcount(rs.getInt(10));
				
				bbs.add(dto);
				
			}
		} catch (Exception e) {
			System.out.println(" selectlistpaging : 게시글 조회 중 오류 발생 ");
			e.printStackTrace();
		}
		return bbs;
	}
	
	
	// 글쓰기 메서드 
	public int insertWrite(MVCBoardDTO dto) {
		int idx = 0;
		try {
			
			String sql = " insert into mvcboard ( idx , name , title , content , ofile , sfile , pass ) " 
						+" values ( seq_board_num.nextval,?,?,?,?,?,? ) ";
			
			psmt = con.prepareStatement(sql);
			psmt.setString(1, dto.getName());
			psmt.setString(2, dto.getTitle());
			psmt.setString(3, dto.getContent());
			psmt.setString(4, dto.getOfile());
			psmt.setString(5, dto.getSfile());
			psmt.setString(6, dto.getPass());
			
			idx = psmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("insertWrite : 게시물 업로드 중 예외 발생");
			e.printStackTrace();
		}
		
		return idx;
	}
	
	// 상세 보기 메서드 
	public MVCBoardDTO selectView(String idx) {
		// 주어진 일련번호에 해당하는 게시물을 dto에 담아 리턴 
		// idx로 DB 게시물에 접근
		MVCBoardDTO dto = new MVCBoardDTO();
		String sql = "select * from mvcboard where idx=?";
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, idx);
			rs = psmt.executeQuery();
			if(rs.next()) {
				dto.setIdx(rs.getString(1));
				dto.setName(rs.getString(2));
				dto.setTitle(rs.getString(3));
				dto.setContent(rs.getString(4));
				dto.setPostdate(rs.getDate(5));
				dto.setOfile(rs.getString(6));
				dto.setSfile(rs.getString(7));
				dto.setDowncount(rs.getInt(8));
				dto.setPass(rs.getString(9));
				dto.setVisitcount(rs.getInt(10));
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("selectView : 예외 발생 ");
		}
		return dto;
	}
	
	// 조회수 증가 메서드 
	public void updateVisitCount(String idx) {
		String sql = " update mvcboard set visitcount=visitcount+1 where idx = ?";
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, idx);
			rs = psmt.executeQuery();
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("updateVisitCount : 예외 발생 ");
		}
	}
	
	public void downCountPlus(String idx) {
		String sql = " update mvcboard set downcount = downcount+1 where idx = ? ";
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, idx);
			psmt.executeUpdate();
			
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("downCountPlus : 예외 발생 ");
			e.printStackTrace();
		}
	}
	
	
	// 입력한 비밀번호가 지정한 일련번호의 게시물의 비밀번호와 일치하는지 확인 
	public boolean confirmPassword(String pass, String idx) {
		
		boolean isCorr = true;
		
		try {
			
			String sql = " select count(*) from mvcboard where pass=? and idx = ?";
			
			System.out.println("confirmPassword SQL : " + sql );
			psmt = con.prepareStatement(sql);
			psmt.setString(1, pass);
			psmt.setString(2, idx);
			
			rs=psmt.executeQuery();
			rs.next();
			// count는 조회된 데이터를 리턴 / 쿼리문으로 조회된 데이터가 있으면 1 없으면 0
			if(rs.getInt(1) == 0) {
				isCorr = false;
			}
			
		} catch (Exception e) {
			isCorr = false;
			System.out.println("confirmPassword : 예외 발생 ");
			e.printStackTrace();
		}
		return isCorr;
	}
	
	// 게시물 삭제 
	public int deletePost(String idx) {
		int result = 0 ;
		
		try {
			String sql = " delete from mvcboard where idx = ?";
			psmt = con.prepareStatement(sql);
			psmt.setString(1, idx);
			result = psmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("deletePost : 예외 발생 ");
			e.printStackTrace();
		}
		
		return result;
	}
	
	// 게시물 수정 
	public int updatePost(MVCBoardDTO dto) {
		int result = 0;
		
		try {
			
			String sql = " update mvcboard set title = ? , name = ? , content = ? , ofile = ? , sfile = ?"
					+ " where idx = ? and pass = ?";
			
			System.out.println("updatePost SQL : " + sql );
			
			psmt = con.prepareStatement(sql);
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getName());
			psmt.setString(3, dto.getContent());
			psmt.setString(4, dto.getOfile());
			psmt.setString(5, dto.getSfile());
			psmt.setString(6, dto.getIdx());
			psmt.setString(7, dto.getPass());
			
			result = psmt.executeUpdate();
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("updatePost : 예외 발생 ");
			e.printStackTrace();
		}
		return result;
	}
}
