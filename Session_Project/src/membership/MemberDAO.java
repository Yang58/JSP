package membership;

import common.JDBConnect;

public class MemberDAO extends JDBConnect{
	public MemberDAO(String drv , String url , String id , String pwd) {
		super(drv , url , id , pwd);
	}
	
	public MemberDTO getMemberDTO(String uid , String upass) {
		MemberDTO dto = new MemberDTO();
		String sql = "select * from member where id=? and pass=?";
		try {
			System.out.println("QUERY 실행 : " + sql);
			psmt = conn.prepareStatement(sql);
			System.out.println("PSMT 실행 : " +psmt);
			psmt.setString(1, uid);
			psmt.setString(2, upass);
			System.out.println("PSMT 실행2 : " +psmt);
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				System.out.println("QUERY2 실행 ");
				dto.setId(rs.getString(1));
				dto.setPass(rs.getString(2));
				dto.setName(rs.getString(3));
				dto.setRegidate(rs.getString(4));
				System.out.println("MemberDTO.class");
				System.out.println(String.format(" ID : %s /  PSSS : %s / NAME : %s / DATE : %s",
						rs.getString("id") , rs.getString("pass") , rs.getString(3) , rs.getString(4)));
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		System.out.println(dto);
		return dto;
	}
}
