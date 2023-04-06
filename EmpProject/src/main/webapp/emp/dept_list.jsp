<%@page import="com.google.gson.Gson"%>
<%@page import="emp.domain.Dept"%>
<%@page import="java.util.List"%>
<%@page import="emp.repository.DeptDAO"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%!
	DeptDAO deptDAO= new DeptDAO();
%>
<%
	List<Dept> deptList= deptDAO.selectAll();
	Gson gson= new Gson();
	String jsonList= gson.toJson(deptList);
	out.print(jsonList);
%>