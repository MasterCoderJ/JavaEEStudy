<%@page import="board.domain.Board"%>
<%@page import="board.repository.BoardDAO"%>
<%@page import="javax.swing.plaf.basic.BasicSplitPaneUI.KeyboardDownRightHandler"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%!
	BoardDAO boardDAO= new BoardDAO();
%>
<%
	String board_idx= request.getParameter("board_idx");
	String title= request.getParameter("title");
	String writer= request.getParameter("writer");
	String content= request.getParameter("content");
	
	Board board= new Board();
	
	board.setTitle(title);
	board.setWriter(writer);
	board.setContent(content);
	
	int result= boardDAO.insert(board);
	
	out.print(result);
	
%>