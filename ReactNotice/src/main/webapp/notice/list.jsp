<%@page import="com.google.gson.Gson"%>
<%@page import="notice.domain.Notice"%>
<%@page import="java.util.List"%>
<%@page import="notice.repository.NoticeDAO"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%!
	NoticeDAO noticeDAO= new NoticeDAO();
%>
<%
	List<Notice> noticeList= noticeDAO.selectAll();
	
	Gson gson= new Gson();
	String jsonList= gson.toJson(noticeList);
	out.print(jsonList);
%>