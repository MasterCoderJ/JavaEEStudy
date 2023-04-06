<%@page import="com.google.gson.Gson"%>
<%@page import="emp.domain.Emp"%>
<%@page import="java.util.List"%>
<%@page import="emp.repository.EmpDAO"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%!
	EmpDAO empDAO= new EmpDAO();
%>
<%
String deptno= request.getParameter("deptno");
System.out.println("deptno"+deptno);
List<Emp> empList= empDAO.selectByFkey(Integer.parseInt(deptno));
Gson gson= new Gson();

String jsonList= gson.toJson(empList);
out.print(jsonList);
%>