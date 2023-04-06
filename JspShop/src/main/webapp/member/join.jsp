<%@page import="com.jspshop.util.ResponseMessage"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.jspshop.util.MessageObject"%>
<%@page import="com.jspshop.exception.MemberException"%>
<%@page import="com.jspshop.repository.MemberDAO"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@page import="com.jspshop.mybatis.MybatisConfig"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%!
	MybatisConfig mybatisConfig = MybatisConfig.getInstance();
	MemberDAO memberDAO = new MemberDAO();
%>
<jsp:useBean id="member" class="com.jspshop.domain.Member"/>
<% 


	SqlSession sqlSession = mybatisConfig.getSqlSession();
	memberDAO.setSqlSession(sqlSession);

%>
<% 
	request.setCharacterEncoding("utf-8");
%>
<jsp:setProperty property="*" name ="member"/>
<%

	
	try{
		
		memberDAO.insert(member);
		sqlSession.commit();
		out.print(ResponseMessage.getMsgURL("가입 완료", "/"));
	}catch(MemberException e){
		out.print(ResponseMessage.getMsgBack(e.getMessage()));
	}finally{
		mybatisConfig.release(sqlSession);
	}
	
	
	
	
%>
