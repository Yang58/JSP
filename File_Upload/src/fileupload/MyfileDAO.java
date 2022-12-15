package fileupload;

import java.util.*;

import javax.servlet.ServletContext;

import common.JDBConnect;

public class MyfileDAO extends JDBConnect{
	
	public MyfileDAO(ServletContext application) {
		super(application);
	}

	public int insertFile(MyfileDTO dto) {
		// dto를 매개변수로 받아 인파라미터 값으로 전달 
		int applyResult = 0;
		
		try {
			// 업로드를 하기위한 SQL문 작성 
			String sql = "insert into myfile ( idx , name , title , cate , ofile, sfile ) "
					+ " values ( seq_board_num.nextval,?,?,?,?,?)";
			System.out.println("Insert SQL : " + sql );
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getName());
			psmt.setString(2, dto.getTitle());
			psmt.setString(3, dto.getCate());
			psmt.setString(4, dto.getOfile());
			psmt.setString(5, dto.getSfile());
			
			applyResult = psmt.executeUpdate();
			
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("insertFile 예외 발생");
			e.printStackTrace();
		}
		return applyResult;
	}

	public List<MyfileDTO> myFileList()	{
		List<MyfileDTO> list = new ArrayList<>();
		
		String sql = "select * from myfile order by idx desc";
		
		System.out.println("myFileList SQL : " + sql );
		try {
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				MyfileDTO dto = new MyfileDTO();
				dto.setIdx(rs.getString(1));
				dto.setName(rs.getString(2));
				dto.setTitle(rs.getString(3));
				dto.setCate(rs.getString(4));
				dto.setOfile(rs.getString(5));
				dto.setSfile(rs.getString(6));
				dto.setPostdate(rs.getString(7));
				
				list.add(dto);
			}
		} catch (Exception e) {
			System.out.println("myFileList 예외 발생 ");
			// TODO: handle exception
		}
		
		return list;
	}
	
}
