package com.mvc3.controller.board;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;

import com.mvc3.controller.Controller;
import com.mvc3.model.board.BoardDAO;
import com.mvc3.mybatis.MybatisConfig;

//목록요청을 처리하는 하위컨트롤러
//3,4단계 수행

public class ListController implements Controller{
	MybatisConfig mybatisConfig= MybatisConfig.getInstance();
	BoardDAO boardDAO= new BoardDAO();
	
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		//목록가져오기
		SqlSession sqlSession= mybatisConfig.getSqlSession();
		boardDAO.setSqlSession(sqlSession);//주입
		
		//3단계: 일 시키기
		List boardList= boardDAO.selectAll();
		
		//4단계: application(서버가동되는 동안 살아있음), session(세션의범위), request(요청종료시까지)
		request.setAttribute("boardList", boardList);
		mybatisConfig.release(sqlSession);
	}

	public String getViewName() {
		
		return "/board/view/list";
	}

	
	public boolean isForward() {
		return true;
	}

}