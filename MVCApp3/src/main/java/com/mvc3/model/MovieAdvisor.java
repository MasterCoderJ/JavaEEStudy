package com.mvc3.model;

//영화 분석 결과를 반환해주는 모델
public class MovieAdvisor {

	public String getAdvisor(String movie) {
		String msg = null;
		
		if(movie.equals("소울")) {
			msg="소울";
		}else if(movie.equals("드래곤길들이기")){
			msg="드래곤길들이기";
		}else if(movie.equals("겨울왕국")){
			msg="겨울왕국";
		}else if(movie.equals("알라딘")){
			msg="알라딘";
		}
		return msg;
	}
}
