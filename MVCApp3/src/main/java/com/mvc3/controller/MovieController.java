package com.mvc3.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mvc3.model.BloodAdvisor;
import com.mvc3.model.MovieAdvisor;

//혈액형에 대한 요청을 처리하는 하위 컨트롤러
//3단계> 일시키기
//4단계> 결과 있으면 저장하기
public class MovieController implements Controller{
	//태그에 bloodController 이름이 담김
	String TAG=this.getClass().getName();
	MovieAdvisor advisor= new MovieAdvisor();
			
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		//String blood = request.getParameter("blood");
		//String msg = advisor.getAdvise(blood);
		System.out.println(TAG+"의 handle 호출");
		
		String movie= request.getParameter("movie");

		//3단계) 일 시키기
		String msg= advisor.getAdvisor(movie);
		
		//4단계)결과 저장
		request.setAttribute("msg", msg);
	}

	@Override
	public String getViewName() {
		return "/movie/view";
	}

	@Override
	public boolean isForward() {
		// TODO Auto-generated method stub
		return false;
	}
}
