<%@page import="com.google.gson.Gson"%>
<%@page import="board.domain.Board"%>
<%@page import="java.util.List"%>
<%@page import="board.repository.BoardDAO"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%!
	BoardDAO boardDAO= new BoardDAO();
%>
<%
	List<Board> boardList= boardDAO.selectAll();
	
	Gson gson= new Gson();
	String jsonList= gson.toJson(boardList);
	out.print(jsonList);
%>