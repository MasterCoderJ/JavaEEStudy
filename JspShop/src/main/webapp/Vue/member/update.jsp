<%@page import="com.google.gson.Gson"%>
<%@page import="com.jspshop.domain.Member"%>
<%@page import="com.jspshop.util.MessageObject"%>
<%@page import="oracle.jdbc.driver.Message"%>
<%@page import="com.jspshop.exception.MemberException"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@page import="com.jspshop.repository.MemberDAO"%>
<%@page import="com.jspshop.mybatis.MybatisConfig"%>
<%@ page contentType="application/json;charset=UTF-8"%>
<%!
	MybatisConfig mybatisConfig= MybatisConfig.getInstance();
	MemberDAO memberDAO= new MemberDAO();
%>

<%request.setCharacterEncoding("utf-8");%>

<jsp:useBean id="member" class="com.jspshop.domain.Member" />

<jsp:setProperty property="*" name="member"/>

<%
	SqlSession sqlSession= mybatisConfig.getSqlSession();
	memberDAO.setSqlSession(sqlSession);
	MessageObject messageObject= new MessageObject();
	
	try{
		
	memberDAO.update(member);
	sqlSession.commit();
	messageObject.setCode(1);
	messageObject.setMsg("수정성공");
		
	}catch(MemberException e){
		messageObject.setCode(1);
		messageObject.setMsg(e.getMessage());
	}finally{
		mybatisConfig.release(sqlSession);
	}
	
	Gson gson= new Gson();
	String json= gson.toJson(messageObject);
	
	out.print(json);
%>