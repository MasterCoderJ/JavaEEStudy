<%@page import="com.google.gson.Gson"%>
<%@page import="emp.domain.Emp"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="emp.repository.EmpDAO"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%!
	EmpDAO empDAO= new EmpDAO();
%>
<%
	String category= request.getParameter("category");
	String keyword= request.getParameter("keyword");
	
	HashMap<String, String> map= new HashMap();
	map.put("category", category);
	map.put("keyword", keyword);
	
	List<Emp> empList= empDAO.selectBySearch(map);
	Gson gson= new Gson();
	String jsonList= gson.toJson(empList);
	
	out.print(jsonList);
%>