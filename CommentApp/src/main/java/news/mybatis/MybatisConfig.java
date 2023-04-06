package news.mybatis;

import java.io.IOException;
import java.io.InputStream;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

//mybatis의 쿼리수행 객체가 SqlSession을 관리해주는 SqlSessionFactory를
//얻기 위한 싱글톤 객체 정의
public class MybatisConfig {
	SqlSessionFactory sqlSessionFactory;
	
	private static MybatisConfig instance;//= new MybatisConfig(); 아래 getInstance 메서드와 동일한 효과
	
	private MybatisConfig() {
		String resource = "news/mybatis/config.xml";
		InputStream inputStream= null;;
		
		try {
			inputStream = Resources.getResourceAsStream(resource);
		} catch (IOException e) {
			e.printStackTrace();
		}
		sqlSessionFactory= new SqlSessionFactoryBuilder().build(inputStream);
	}
	
	public static MybatisConfig getInstance() {
		if(instance==null) {
			instance= new MybatisConfig();
		}
		
		return instance;
	}

	
	//세션 팩토리로부터 쿼리수행객체 하나 얻기
	public SqlSession getSqlSession() {
		return sqlSessionFactory.openSession();
	}
	
	//쿼리 수행객체 닫기
	public void release(SqlSession sqlSession) {
		if(sqlSession!=null) {
			sqlSession.close();
		}
	}
}
