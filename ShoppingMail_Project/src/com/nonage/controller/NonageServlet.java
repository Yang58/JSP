package com.nonage.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.nonage.controller.action.Action;

@WebServlet("/NonageServlet")
public class NonageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public NonageServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 1단계. 클라이언트로부터 command요청을 받는다 ( 쿼리스트링으로 요청된 데이터 ) 
		String command = request.getParameter("command"); // 클라이언트로부터 요청받은 값 확인 
		System.out.println("NonageServlet에서 요청 받음을 확인 " + command);
		
		// 2단계. 받은 요청 값을 Action Factory에 요청 전달 
		ActionFactory af = ActionFactory.getInstance();
		Action action = af.getAction(command);
		
		// 3단계. 전달 받은 actionContorller를 실행
		if(action != null) {
			action.execute(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		doGet(request,response);
	}

}
