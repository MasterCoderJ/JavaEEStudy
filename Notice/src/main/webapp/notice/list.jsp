<%@page import="notice.domain.Notice"%>
<%@page import="notice.repository.NoticeDAO"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page contentType="application/json;charset=UTF-8"%>
<%!
	NoticeDAO noticeDAO = new NoticeDAO();
%>
<%
	List<Notice> noticeList=noticeDAO.selectAll();
	
	Gson gson = new Gson();
	String jsonList=gson.toJson(noticeList);
	out.print(jsonList);
%>











