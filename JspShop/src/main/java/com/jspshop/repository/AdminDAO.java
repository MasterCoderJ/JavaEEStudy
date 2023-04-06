package com.jspshop.repository;

import org.apache.ibatis.session.SqlSession;

import com.jspshop.domain.Admin;
import com.jspshop.mybatis.MybatisConfig;

public class AdminDAO {

	
	MybatisConfig config = MybatisConfig.getInstance();
	
	public Admin select(Admin admin) {
		
		Admin obj = null;
		
		SqlSession sqlSession = config.getSqlSession();
		obj = sqlSession.selectOne("Admin.select",admin);
		config.release(sqlSession);
		
		
		return obj;
	}
	
}
