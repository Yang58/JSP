package common;


public class Person {
	
	/* 역할적 용어 : DTO class
	 * 자바 빈즈 규약  
	 * 기본(default) 패키지 이외의 패키지에 속해야한다.
	 * 멤버 변수(속성) 의 접근지정자는 private 여야한다.
	 * 기본 생성자가 있어야한다
	 * 변수에 접근할수있는 게터 세터가 선언되어야한다.
	 * 게터 세터는 public 해야한다. 
	 */

	private String name;
	private int age;
	
	public Person() {}
	public Person(String name, int age) {
		this.name = name;
		this.age = age;
	}
	
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public int getAge() {
		return age;
	}
	
	public void setAge(int age) {
		this.age = age;
	}
	

}
