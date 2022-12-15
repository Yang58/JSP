package fileupload;

public class MyfileDTO {

	private String idx;
	private String name;
	private String title;
	private String cate ;
	private String ofile; // 올리는 파일 이름 
	private String sfile; // 서버에 저장되는 파일 이름  ( 파일이름의 중복을 막기위해 서버에 저장되는 이름은 다르게 저장되야함) 
	private String postdate;
	
	
	public String getIdx() {
		return idx;
	}
	public void setIdx(String idx) {
		this.idx = idx;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getCate() {
		return cate;
	}
	public void setCate(String cate) {
		this.cate = cate;
	}
	public String getOfile() {
		return ofile;
	}
	public void setOfile(String ofile) {
		this.ofile = ofile;
	}
	public String getSfile() {
		return sfile;
	}
	public void setSfile(String sfile) {
		this.sfile = sfile;
	}
	public String getPostdate() {
		return postdate;
	}
	public void setPostdate(String postdate) {
		this.postdate = postdate;
	}
	
	
}
