package model2.mvcboard;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import common.DBConnPool;

public class MVCBoardDAO extends DBConnPool{

	public MVCBoardDAO() {
		super();
	}

	// 뷰에 보여줄 게시물의 개수를 구하는 메서드 
	public int selectCount(Map<String, Object> map) {
		int result = 0;
		
		String sql = "select count(*) from mvcboard";
		if(map.get("searchWord") != null ) {	
			sql += " where " + map.get("searchField") + " " + " like '%" + map.get("searchWord") +"%'";
		}
		System.out.println(" DAO selectCount SQL구문 : " + sql );
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			rs.next();
			result = rs.getInt(1);
			
		} catch (Exception e) {
			System.out.println("전체 게시물 개수를 구하는 중 예외 발생 ");
			e.printStackTrace();
		}
		System.out.println("result : " + result );
		return result;
	}

	public List<MVCBoardDTO> selectListPage(Map<String, Object> map) {

		List<MVCBoardDTO> list = new ArrayList<>();
		
		String sql = "select * from ( select tb.* , rownum rnum from ( select * from mvcboard ";
		
		if(map.get("searchWord") != null) {
			sql += " where " + map.get("searchField") + " like '%" + map.get("searchWord") +"%' ";
		}
		sql += " order by idx desc ) tb ) where rnum between ? and ?";
			
		System.out.println(" DAO selectListPage SQL구문 : " + sql );
		
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, map.get("start").toString());
			psmt.setString(2, map.get("end").toString());
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				
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
				
				list.add(dto);
				
			}
			
		} catch (Exception e) {
			System.out.println("게시물 페이징 중 예외 발생 ");
			e.printStackTrace();
			// TODO: handle exception
		}
		
		return list;
	}
	
	
}
