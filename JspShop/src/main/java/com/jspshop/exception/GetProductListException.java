package com.jspshop.exception;

public class GetProductListException extends RuntimeException{
public GetProductListException(String msg) {
		
		//개발자가 전달하고픈 에러 메시지...
		super(msg);
	
	}
}

