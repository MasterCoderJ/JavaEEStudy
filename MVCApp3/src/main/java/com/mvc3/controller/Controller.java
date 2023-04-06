package com.mvc3.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//Movie, BloodController등의 모든 하위 컨트롤러의 최상위 클래스
public interface Controller {
	public void execute(HttpServletRequest request, HttpServletResponse response);
	
	//뷰페이지 반환
	public String getViewName();
	
	//포워딩 여부
	public boolean isForward();
}
