package com.jspshop.domain;

import java.util.List;

import lombok.Data;

@Data
public class Product {
	private int product_idx;
	private Category category; //mybatis 에서 부모와 자식을 association으로 추가
	private String product_name;
	private String brand;
	private int price;
	private int discount;
	private String detail;
	
	//하나의 상품이 거느리고 있는 자식 테이블을 표현한 DTO들...
	
	private List<Psize> psizeList;
	private List<Color> colorList;
	private List<Pimg> pimgList;
}
