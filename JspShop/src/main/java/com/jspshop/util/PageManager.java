package com.jspshop.util;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import lombok.Data;
@Data
public class PageManager {
	private int totalRecord;//총 레코드 수
	private int pageSize=10;//
	private int totalPage;
	private int blockSize=10;
	private int currentPage=1;
	private int firstPage;
	private int lastPage;
	private int curPos;//페이지당 ArrayList의 시작 인덱스
	private int num;
	
	public void init(List list,HttpServletRequest request) {
		totalRecord = list.size();
		totalPage = (int)Math.ceil((float)totalRecord/pageSize);
		
		
		//넘어온 페이지 값이 있으면 그 값으로 대체
		if(request.getParameter("currentPage")!=null) {
			
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		firstPage = currentPage -(currentPage-1)%blockSize;
		lastPage = firstPage+(blockSize-1);
		curPos = (currentPage-1)*pageSize;
		num = totalRecord-curPos;
	}
}
