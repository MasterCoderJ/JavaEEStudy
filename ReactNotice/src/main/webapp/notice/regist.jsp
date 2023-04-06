<%@page import="com.google.gson.Gson"%>
<%@page import="notice.domain.Notice"%>
<%@page import="notice.repository.NoticeDAO"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%!
	NoticeDAO noticeDAO= new NoticeDAO();
%>
<%
	
	String title= request.getParameter("title");
	String writer= request.getParameter("writer");
	String content= request.getParameter("content");
	
	Notice notice= new Notice();
	notice.setTitle(title);
	notice.setWriter(writer);
	notice.setContent(content);
	
	int result= noticeDAO.insert(notice);
	Gson gson = new Gson();
	
	out.print(gson.toJson(result));
%>


