package com.mvc3.controller.board;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;

import com.mvc3.controller.Controller;
import com.mvc3.model.board.BoardDAO;
import com.mvc3.mybatis.MybatisConfig;

public class DeleteController implements Controller{
	MybatisConfig mybatisConfig= MybatisConfig.getInstance();
	BoardDAO boardDAO= new BoardDAO();
	
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		SqlSession sqlSession= mybatisConfig.getSqlSession();
		boardDAO.setSqlSession(sqlSession);
		
		String board_idx= request.getParameter("board_idx");
		boardDAO.delete(Integer.parseInt(board_idx));
		
		request.setAttribute("board_idx", board_idx);
		sqlSession.commit();
		mybatisConfig.release(sqlSession);
	}

	public String getViewName() {
		return "/board/view/delete";
	}

	public boolean isForward() {
		return false;//재접속
	}

}
