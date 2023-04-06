package mvc.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mvc.model.blood.BloodAdvisor;

public class BloodController {

	BloodAdvisor advisor= new BloodAdvisor();
	
	protected void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		
		String blood= request.getParameter("blood");
		
		String msg= advisor.getAdvise(blood);
		
		System.out.println(msg);
		
		request.setAttribute("msg", msg);
		
	}
}
