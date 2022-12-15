package member;

import common.JDBConnect;

public class MemberDAO extends JDBConnect{
	public MemberDAO(String driver , String url , String id , String pw) {
		super(driver , url , id , pw);
	}
	
	public MemberDTO getMemberDTO(String uid , String pass) {
		MemberDTO dto = new MemberDTO();
		String sql = "select * from member where id=? and pass=?";
		try {
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, uid);
			psmt.setString(2, pass);

			rs = psmt.executeQuery();
			
			if(rs.next()) {
				dto.setId(rs.getString(1));
				dto.setPw(rs.getString(2));
				dto.setName(rs.getString(3));
				dto.setDate(rs.getString(4));
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return dto;
	}
}
