package board.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import board.domain.Board;
import board.mybatis.MybatisConfig;

public class BoardDAO {
	MybatisConfig config= MybatisConfig.getInstance();
	
	public int insert(Board board) {
		int result=0;
		SqlSession sqlSession= config.getSqlSession();
		result= sqlSession.insert("Board.insert", board);
		sqlSession.commit();
		config.release(sqlSession);
		return result;
	}
	
	public List selectAll() {
		List list= null;
		SqlSession sqlSession= config.getSqlSession();
		list= sqlSession.selectList("Board.selectAll");
		config.release(sqlSession);
		return list;
	}
}
