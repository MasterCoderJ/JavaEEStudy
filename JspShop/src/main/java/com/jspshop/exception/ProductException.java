package com.jspshop.exception;

public class ProductException extends RuntimeException{

	public ProductException(String msg) {
		
		//개발자가 전달하고픈 에러 메시지...
		super(msg);
	
	}
	
}
