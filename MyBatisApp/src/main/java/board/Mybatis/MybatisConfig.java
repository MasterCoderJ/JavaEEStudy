package board.Mybatis;

import java.io.IOException;
import java.io.InputStream;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

//mybatis의 설정 정보를 읽어와서, 쿼리를 수행하는 객체인 SQLSession객체를 모아서
//관리해주는 sqlSessionFactory를 싱글턴 클래스로 관리해보자
public class MybatisConfig {
	private static MybatisConfig instance;
	
	//SqlSession들이 모여사는 공장
	SqlSessionFactory sqlSessionFactory= null;
	
	private MybatisConfig() {
		String resource="board/Mybatis/config.xml";
		
		//순수 jdbc코드에서는 쿼리 실행을 담당하는 객체는 PreparedStatement였지만,
		//mybatis에서는 jdbc를 wrapper하여 SqlSession이라는 쿼리수행객체를 지원해준다.
		//즉, 내부적으로는 사실 jdbc가 사용되고 있다
		//따라서, 개발자가 쿼리문을 수행하기 위해서는 SQLsession을 얻어와야하는데
		//이 Sqlsession을 관리해주고 반환해주는 객체가 바로 SQLSessionFctory이다.
		
		try {
			InputStream inputStream = Resources.getResourceAsStream(resource);
			sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	//SqlSessionFactory로부터 쿼리수행 객체인 SqlSession을 반환해줄 수 있는 메서드 정의
	public SqlSession getSqlSession() {
		//팩토리로부터 쿼리수행 객체인 SqlSession 하나 반환해주기
		return sqlSessionFactory.openSession();
	}
	
	//넘겨받은 SqlSession 닫아주기 poolmanager처럼
	public void release(SqlSession sqlSession) {
		if(sqlSession!=null) {
			sqlSession.close();
		}
	}
	
	public static MybatisConfig getInstance() {
		if(instance==null) {
			instance= new MybatisConfig();
		}
		return instance;
	}
}
