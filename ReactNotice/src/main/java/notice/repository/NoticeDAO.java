package notice.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import notice.domain.Notice;
import notice.mybatis.MybatisConfig;

public class NoticeDAO {

	MybatisConfig config= MybatisConfig.getInstance();

	public int insert(Notice notice) {
		int result=0;
		SqlSession sqlSession= config.getSqlSession();
		result= sqlSession.insert("Notice.insert", notice);
		sqlSession.commit();
		config.release(sqlSession);
		return result;
	}
	
	public List selectAll() {
		List list= null;
		SqlSession sqlSession= config.getSqlSession();
		list= sqlSession.selectList("Notice.selectAll");
		config.release(sqlSession);
		return list;
	}

}
