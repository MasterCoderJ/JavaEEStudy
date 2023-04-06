package com.mvc3.controller.board;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;

import com.mvc3.controller.Controller;
import com.mvc3.domain.Board;
import com.mvc3.model.board.BoardDAO;
import com.mvc3.mybatis.MybatisConfig;

public class UpdateController implements Controller{
	MybatisConfig mybatisConfig= MybatisConfig.getInstance();
	BoardDAO boardDAO= new BoardDAO();
	
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		SqlSession sqlSession= mybatisConfig.getSqlSession();
		boardDAO.setSqlSession(sqlSession);
		
		String board_idx= request.getParameter("board_idx");
		String title= request.getParameter("title");
		String writer= request.getParameter("writer");
		String content= request.getParameter("content");
		
		Board board= new Board();
		
		board.setBoard_idx(Integer.parseInt(board_idx));
		board.setTitle(title);
		board.setWriter(writer);
		board.setContent(content);
		
		boardDAO.update(board);
		
		request.setAttribute("board", board);
		sqlSession.commit();
		mybatisConfig.release(sqlSession);
	}

	public String getViewName() {
		return "/board/view/update";
	}

	public boolean isForward() {
		return true;
	}

}
