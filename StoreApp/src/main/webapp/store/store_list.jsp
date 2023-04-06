<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.List"%>
<%@page import="store.repository.StoreDAO"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%!
	StoreDAO storeDAO=new StoreDAO();
%>
<%
//	System.out.print(""); //서버에 찍히는거. 동기..
//	out.print(""); //비동기든 동기든 이건 무조건 해줘야한다. 
//비동기이던, 동기이던 무조건 서버는 응답을 해야한다.
//1) 동기로 들어온 클라이언트 : html로 응답
//2) 비동기로 들어온 클라이언트 : 화면 전체가 아닌 순수 데이터만 보내면 된다.
//지금은, 비동기로 할거니까 2번으로 순수데이터만 보낼거임

	List storeList=storeDAO.selectAll();
	
	//자바의 자료형을 자동으로 json 문자열로 변환해주는 라이브러리!!!
	//gson
	Gson gson=new Gson();
	String result=gson.toJson(storeList);
	out.print(result);

%>