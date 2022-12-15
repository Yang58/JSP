package common;

import java.sql.Date;

public class CreateTable {
	
	public CreateTable() {
		
	}
	
	public String table(int empno , String ename , String job , int mgr , Date date , int sal , int comm , int deptno) {
		
		String table = 
				"<tr>"
					+"<th>"+empno+"</th>"
					+"<th>"+ename+"</th>"
					+"<th>"+job+"</th>"
					+"<th>"+mgr+"</th>"
					+"<th>"+date+"</th>"
					+"<th>"+sal+"</th>"
					+"<th>"+comm+"</th>"
					+"<th>"+deptno+"</th>"
				+"</tr>";
		
		return table;
	}
}
