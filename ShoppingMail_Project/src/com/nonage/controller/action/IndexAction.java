package com.nonage.controller.action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.nonage.dao.ProductDAO;
import com.nonage.dto.ProductVO;

public class IndexAction implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String url = "/index.jsp";
		
		// 1. DAO를 이용한 처리 
		ProductDAO productDao = ProductDAO.getInstance();
		ArrayList<ProductVO> newProductList = productDao.listNewProduct();
		ArrayList<ProductVO> bestProductList = productDao.listBestProduct();
		
		request.setAttribute("newProductList", newProductList);
		request.setAttribute("bestProductList", bestProductList);
		
		// 2. 처리한 데이터를 넘겨쥴 뷰.jsp 페이지를 지정하고 페이지 이동  
		RequestDispatcher dispatcher = request.getRequestDispatcher(url);
		dispatcher.forward(request, response);
		
		
	}
	
	
}
