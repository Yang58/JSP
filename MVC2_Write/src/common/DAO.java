package common;

public class DAO extends DBConnPool{
	
	public DAO() {
		super();
	}
	

	public int insertW(DTO dto) {
		int r = 0 ; 

		String sql = " insert into mvcboard ( idx , name , title , content , ofile , sfile , pass ) " 
				+" values ( seq_board_num.nextval,?,?,?,?,?,? ) ";
		
		try {
			
			psmt = con.prepareStatement(sql);
			psmt.setString(1, dto.getName());
			psmt.setString(2, dto.getTitle());
			psmt.setString(3, dto.getContent());
			psmt.setString(4, dto.getOfile());
			psmt.setString(5, dto.getSfile());
			psmt.setString(6, dto.getPass());
			
			r = psmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("업로드중 예외발생");
		}
		
		return r;
	}

}
