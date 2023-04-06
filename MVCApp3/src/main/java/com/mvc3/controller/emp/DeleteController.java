package com.mvc3.controller.emp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mvc3.controller.Controller;
import com.mvc3.domain.Emp;
import com.mvc3.model.emp.EmpService;

//사원들 삭제요청을 처리하는 하위 컨트롤러
public class DeleteController implements Controller{
	
	EmpService empService= new EmpService();
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String[] empno= request.getParameterValues("empno");
		
		//3단계:
		for(int i=0; i<empno.length; i++) {
			System.out.println(empno[i]);
			Emp emp= empService.select(Integer.parseInt(empno[i]));
			empService.remove(emp);
		}
		
	}

	@Override
	public String getViewName() {
		return "/emp/view/del";
	}
	@Override
	public boolean isForward() {
		return false;
	}
}
