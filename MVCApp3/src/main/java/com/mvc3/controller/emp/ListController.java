package com.mvc3.controller.emp;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mvc3.controller.Controller;
import com.mvc3.model.emp.EmpService;

public class ListController implements Controller{
	
	EmpService empService= new EmpService();
	
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("목록요청을 처리할 예정");
		
		//3단계 일 시키기
		List empList= empService.selectAll();
		
		//empList가 jsp까지 살아있어야하므로, application, session, request 중 원하는 곳에 보관해놓을 수 있다
		//특히, request에 넣게되면 요청에 대한 응답을 아직 하면 안되고 서버상에 존재하는 결과 jsp로 곧바로 포워딩 해야한다
		
		//4단계
		request.setAttribute("empList", empList);
	}

	public String getViewName() {
		return "/emp/view/list";
	}

	public boolean isForward() {
		return true;
	}

}
