package com.jspshop.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.jspshop.domain.Product;
import com.jspshop.exception.ProductException;

public class ProductDAO {

	private SqlSession sqlSession;

	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	//throws는 예외를 처리하는것이 아니라 회피이다, 즉, 전가하는것이다
	public void insert(Product product) throws ProductException{
		int result = 0;
		System.out.println("마이바티스이전 p_idx"+product.getProduct_idx());
		result = sqlSession.insert("Product.insert",product);
		System.out.println("이후 p_idx"+product.getProduct_idx());
		if(result<1) {
			//일부러 에러를 일으키자
			throw new ProductException("상품이 등록되지않았어요!");
		}
		
	}
	
	public List selectAll(){
		
		List list = null;
		
		list = sqlSession.selectList("Product.selectAll");

		return list;
	}
	public List selectBySearch(Map map){
		
		List list = null;
		
		list = sqlSession.selectList("Product.selectAll",map);

		return list;
	}
	
	
	public List selectByCategory(int category_idx) {
		return sqlSession.selectList("Product.selectByCategory", category_idx);
	}
	
	public Product select(int product_idx) {
		return sqlSession.selectOne("Product.select", product_idx);
	}
}
