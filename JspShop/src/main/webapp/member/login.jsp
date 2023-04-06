<%@page import="com.jspshop.util.ResponseMessage"%>
<%@page import="com.jspshop.exception.MemberException"%>
<%@page import="com.jspshop.domain.Member"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@page import="com.jspshop.repository.MemberDAO"%>
<%@page import="com.jspshop.mybatis.MybatisConfig"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%!
	MybatisConfig mybatisConfig = MybatisConfig.getInstance();
	MemberDAO memberDAO = new MemberDAO();
%>
<%
	//로그인 성공 후 사용자의 기록을 메모리에 남겨놓기 위해 세션객체에 로그인한 결과인 DTO를 담아놓자 키 이름 member로!
	//쇼핑몰 메인으로
	SqlSession sqlSession = mybatisConfig.getSqlSession();
	memberDAO.setSqlSession(sqlSession);
	
	Member member = new Member();
	
	System.out.println("여기까지는 오나?");
	
	
	
	member.setId(request.getParameter("id"));
	member.setPass(request.getParameter("pass"));
	
	try{
		Member obj = memberDAO.select(member);
		session.setAttribute("member", obj);
		//메인페이지 보여주기
		out.print(ResponseMessage.getMsgURL("야호 로그인 성공", "/"));
	}catch(MemberException e){
		//
		out.print(ResponseMessage.getMsgBack(e.getMessage()));
	}finally{
		mybatisConfig.release(sqlSession);
	}
	
%>