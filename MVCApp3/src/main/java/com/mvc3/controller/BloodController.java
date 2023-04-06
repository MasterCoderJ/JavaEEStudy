package com.mvc3.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mvc3.model.BloodAdvisor;

//혈액형에 대한 요청을 처리하는 하위 컨트롤러
//3단계> 일시키기
//4단계> 결과 있으면 저장하기
public class BloodController implements Controller{
	//태그에 bloodController 이름이 담김
	String TAG=this.getClass().getName();
	BloodAdvisor advisor= new BloodAdvisor();
			
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		//String blood = request.getParameter("blood");
		//String msg = advisor.getAdvise(blood);
		System.out.println(TAG+"의 execute 호출");
		
		//3단계)알맞는 로직객체에 일시키기
		String blood= request.getParameter("blood");
		String msg= advisor.getAdvise(blood);
		
		//4단계)request, response 객체가 아직 살아있으므로, 요청 객체에 결과 저장
		//4단계의 결과저장 절차가 있을 경우 무조건 request는 살아있어야 하므로, 포워딩 처리 해야한다
		request.setAttribute("msg", msg);
		
	}

	@Override
	public String getViewName() {
		return "/blood/view";
	}

	@Override
	public boolean isForward() {
		// TODO Auto-generated method stub
		return false;
	}
}
