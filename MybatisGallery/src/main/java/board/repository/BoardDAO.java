package board.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import board.domain.Board;
import board.mybatis.MybatisConfig;

public class BoardDAO {
	//아래의 싱글턴 객체의 인스턴스가 메모리에 생성될때, 동시에 맴버변수로 존재하는 SqlSessionFactory로 올라간다!!(한번만)
	MybatisConfig config= MybatisConfig.getInstance();
	
	public int insert(Board board) {
		int result=0;
		SqlSession sqlSession= config.getSqlSession();
		result= sqlSession.insert("Board.insert", board);
		sqlSession.commit();//DML의 경우
		config.release(sqlSession);//닫기
		return result;
	}
	
	public List selectAll() {
		List list= null;
		SqlSession sqlSession= config.getSqlSession();
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
		result= sqlSession.update("Board.update",board);
		sqlSession.commit();
		config.release(sqlSession);
		
		return result;
	}
}
