<%@page import="com.jspshop.domain.Category"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.List"%>
<%@page import="com.jspshop.repository.CategoryDAO"%>
<%@ page contentType="application/json;charset=UTF-8"%>
<%! CategoryDAO categoryDAO = new CategoryDAO(); %>
<%

	List<Category> list = categoryDAO.selectAll();

	Gson gson = new Gson();
	
	String result = gson.toJson(list);
	
	out.print(result);
	

%>