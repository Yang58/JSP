package JDBC;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletContext;

public class DAO extends DBconnect{
	
	public DAO(ServletContext application) {
		super(application);
	}
	
	public int BoardSize(Map<String , Object> map) {
		int count = 0;
		String sql = "select count(*) from board ";
		if(map.get("Word") != null) {
			sql += "where " + map.get("Field") +" "+ "Like '%" + map.get("Word") + "%'";
		}
		sql += ";";
		
		System.out.println("Board Size SQL : " + sql );
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			rs.next();
			count = rs.getInt(1);
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("총 게시글 크기 계산 중 오류 발생");
			e.printStackTrace();
		}
		return count;
	}
	
	public List<DTO> Search(Map<String , Object> map){
		List<DTO> search = new ArrayList<>();
		DTO dto = new DTO();
		
		String sql = "select * from board ";
		if(map.get("Word") != null) {
			sql += "where " + map.get("Field") +" "+ "Like '%" + map.get("Word") + "%'";
		}
		sql += "order by num desc ;";
		
		System.out.println("Search SQL : " + sql );
		
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			
			while(rs.next()) {
				dto.setNum(rs.getString(1));
				dto.setTitel(rs.getString(2));
				dto.setContent(rs.getString(3));
				dto.setId(rs.getString(4));
				dto.setPostdate(rs.getString(5));
				dto.setVisitcount(rs.getString(6));
				
				search.add(dto);
			}
			
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("게시글 검색 중 오류 발생 ");
			e.printStackTrace();
		}
		return search;
	}
	
}
