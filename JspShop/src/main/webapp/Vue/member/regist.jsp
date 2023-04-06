<%@page import="com.google.gson.Gson"%>
<%@page import="com.jspshop.util.MessageObject"%>
<%@page import="com.jspshop.exception.MemberException"%>
<%@page import="com.jspshop.repository.MemberDAO"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@page import="com.jspshop.mybatis.MybatisConfig"%>
<%@ page contentType="application/json;charset=UTF-8"%>
<%!
	MybatisConfig mybatisConfig = MybatisConfig.getInstance();
	MemberDAO memberDAO = new MemberDAO();
%>
<% 

	SqlSession sqlSession = mybatisConfig.getSqlSession();
	memberDAO.setSqlSession(sqlSession);

	request.setCharacterEncoding("utf-8");

%>
<jsp:useBean id="member" class="com.jspshop.domain.Member"/>
<jsp:setProperty property="*" name ="member"/>
<%

	System.out.println(member.getId());
	System.out.println(member.getPass());
	System.out.println(member.getName());
	System.out.println(member.getEmail());
	
	MessageObject mo = new MessageObject();
	
	try{
		
		memberDAO.insert(member);
		mo.setCode(1);
		mo.setMsg("등록 성공");
		sqlSession.commit();
	}catch(MemberException e){
		mo.setCode(0);
		mo.setMsg(e.getMessage());
	}
	
	Gson gson = new Gson();
	
	out.print(gson.toJson(mo));
	
	
	
	mybatisConfig.release(sqlSession);
%>
