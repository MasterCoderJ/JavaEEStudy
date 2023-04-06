package com.mvc3.model.emp;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.mvc3.domain.Emp;
import com.mvc3.exception.DeptException;
import com.mvc3.exception.EmpException;
import com.mvc3.mybatis.MybatisConfig;

/*
 이 객체는 모델 파트에서의 서비스 역할을 수행한다, 만일 서비스의 존재가 없다면
 컨트롤러가 너무 세부적인 모델 파트의 업무를 수행하게 된다.
 또한, 트랜잭션 상황에서 각각의 DAO들의 업무 수행이 성공했는지 여부를 판단하여
 트랜잭션을 commit할지 rollback할지 결정을 짓는 역할을 수행한다
 
 주의) 직접 일하지 않고 각종 모델 영역의 객체들에게 일을 시킨다
 */
public class EmpService {
	
	MybatisConfig mybatisConfig= MybatisConfig.getInstance();
	DeptDAO deptDAO;
	EmpDAO empDAO;
	
	
	public EmpService() {
		deptDAO= new DeptDAO();
		empDAO= new EmpDAO();
	}
	
	//사원 등록
	public void regist(Emp emp) {
		//세션 얻어와서 배분하기(주입)
		SqlSession sqlSession= mybatisConfig.getSqlSession();
		deptDAO.setSqlSession(sqlSession);
		empDAO.setSqlSession(sqlSession);
		
		try {
			deptDAO.insert(emp.getDept());
			empDAO.insert(emp);
			sqlSession.commit();
		} catch (DeptException e) {
			sqlSession.rollback();
			e.printStackTrace();
		}catch (EmpException e) {
			sqlSession.rollback();
			e.printStackTrace();
		}finally {
			mybatisConfig.release(sqlSession);
		}
	}
	
	public Emp select(int empno) {
		
		SqlSession sqlSession= mybatisConfig.getSqlSession();
		empDAO.setSqlSession(sqlSession);
		Emp emp= empDAO.select(empno);
		mybatisConfig.release(sqlSession);
		return emp;
	}
	
	
	public List selectAll() {
		SqlSession sqlSession= mybatisConfig.getSqlSession();
		empDAO.setSqlSession(sqlSession);
		
		List list= empDAO.selectAll();
		mybatisConfig.release(sqlSession);
		return list;
	}
	
	//사원 퇴사처리(부서, 사원 둘다 삭제)
	public void remove(Emp emp) {
		SqlSession sqlSession= mybatisConfig.getSqlSession();
		deptDAO.setSqlSession(sqlSession);
		empDAO.setSqlSession(sqlSession);

		try {
			//사원 삭제
			//부서 삭제
			empDAO.delete(emp.getEmpno());
			deptDAO.delete(emp.getDept().getDeptno());
			sqlSession.commit();
		} catch (EmpException e) {
			e.printStackTrace();
			sqlSession.rollback();
		} catch (DeptException e) {
			e.printStackTrace();
			sqlSession.rollback();
		}finally{
			mybatisConfig.release(sqlSession);
		}
		
		
	}
}
