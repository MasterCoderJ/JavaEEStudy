package mvc.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mvc.model.blood.BloodAdvisor;

public class DispatcherServlet extends HttpServlet{
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doRequest(request, response);
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doRequest(request, response);
	}
	
	protected void doRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		System.out.println("요청받음");
		
		String uri= request.getRequestURI();
		System.out.println("클라이언트의 요청 URI는"+uri);
		
		if(uri.equals("/blood.do")) {
			BloodController controller= new BloodController();
			controller.execute(request, response);
			
		}
		
		RequestDispatcher dis= request.getRequestDispatcher("/blood/result.jsp");
		
		dis.forward(request, response);
	}
	
	
}
