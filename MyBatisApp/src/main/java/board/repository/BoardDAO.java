package board.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import board.Mybatis.MybatisConfig;
import board.domain.Board;

public class BoardDAO {
	
	MybatisConfig config= MybatisConfig.getInstance();
	
	public int insert(Board board) {
		int result=0;
		
		SqlSession sqlSession= config.getSqlSession();
		result=sqlSession.insert("Board.insert",board);
		sqlSession.commit();
		config.release(sqlSession);
		return result;
	}
	
	public List selectAll() {
		List list= null;
		SqlSession sqlSession=config.getSqlSession();
		list= sqlSession.selectList("Board.selectAll");
		config.release(sqlSession);
		return list;
	}
	
	public Board select(int board_idx) {
		Board board= null;
		SqlSession sqlSession= config.getSqlSession();
		board= sqlSession.selectOne("Board.select", board_idx);
		config.release(sqlSession);
		return board;
	}
	
	public int update(Board board) {
		int result=0;
		SqlSession sqlSession= config.getSqlSession();
		sqlSession.update("Board.update", board);
		sqlSession.commit();
		config.release(sqlSession);
		return result;
	}

}
