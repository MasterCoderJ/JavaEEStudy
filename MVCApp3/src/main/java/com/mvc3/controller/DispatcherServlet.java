package com.mvc3.controller;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.Properties;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//모든 요청을 받는 1차 진입점이 되어야하므로 컨트롤러로서의 역할을 서블릿이 담당한다(request, response 객체 필요)
/*1) 요청받는다(메인 컨트롤러)
 * 2) 요청을 분석한다(메인 컨트롤러)
 * 3) 로직 객체에게 업무를 할당한다(서브 컨트롤러)
 * 4) 결과가 있는 경우 결과 저장(서브 컨트롤러)
 * 5) 알맞는 결과 페이지를 보여준다(메인 컨트롤러) > 서브가 할 수는 있으나 그러면 메인을 생성한 의미가 없음
 * */

public class DispatcherServlet extends HttpServlet{

	//2단계 업무인 '요청을 분석한다' 단계에서 if문을 사용하지 않으려면 적어도 2단계이전에
	//이미 Properties가 준비가 되어 있어야한다. 따라서 서블릿이 태어날때 이미 준비해놓자
	Properties props;
	FileInputStream fis;
	
	//ServletConfig: 서블릿에 전달된 환경정보를 담고 있는 객체
	public void init(ServletConfig config) throws ServletException {
		props= new Properties();//key-value 쌍을 해석할 수 있는 객체 생성
		try {
			//getRealPath()를 이용하려면, jsp의 경우 내장객체 중 application내장객체 이용하면됨
			//하지만, 이 영역은 서블릿이기에, application 내장객체의 자료형인 ServletContext이용
			ServletContext context= config.getServletContext();//서버가 가동될때 생성되는 서버의 전역적 정보를 가진 객체
			String contextConfigLocation= config.getInitParameter("contextConfigLocation");
			System.out.println("넘겨받은 초기화 파라미터는"+ contextConfigLocation);
			String realPath= context.getRealPath(contextConfigLocation);
			
			System.out.println("매핑파일의 실제 위치는"+realPath);
			
			fis= new FileInputStream(realPath);
			props.load(fis);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	//여러 방식을 모두 받아와야함.
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doRequest(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doRequest(request, response);
	}
	
	protected void doRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1. 요청 받는다
		System.out.println("나 호출됐옹");
		
		//파라미터 인코딩 처리
		request.setCharacterEncoding("utf-8");
		
		//2. 요청 분석한다
		String uri = request.getRequestURI();
		System.out.println("당신의 요청 uri는"+uri);
		
		String controllerPath= props.getProperty(uri);
		System.out.println("요청 uri에 동작할 하위컨트롤러의 경로는"+controllerPath);
		
		try {
			//정적 영역에 원본을 을리고, 그 반환된 결과로 Class자료형을 반환받자
			Class controllerClass= Class.forName(controllerPath); //static영역에 올린다(거푸집원본)
			
			//인스턴스 올리기
			//인스턴스를 메모리에 올리는 방법은 new 연산자만 있는게 아니다
			Controller controller= (Controller)controllerClass.getDeclaredConstructor().newInstance();
			controller.execute(request, response);
			
			String viewName=controller.getViewName();
			System.out.println("하위컨트롤러에서 반환받은 뷰이름은"+viewName);
			String viewPage= props.getProperty(viewName);
			System.out.println("뷰 이름의 검색결과는"+viewPage);
			
			//포워딩할 경우
			if(controller.isForward()==true) {
				RequestDispatcher dis= request.getRequestDispatcher(viewPage);
				dis.forward(request, response);//전달
				
			}else {
				//리다이렉트할 경우(재접속)
				//지정한 url로 재접속을 유도함, 따라서 클라이언트인 웹브라우저는 서버로부터 응답을 받자마자,
				//지정한 url로 재접속을 시도함 
				//전화끊고, 새로운 다이얼눌러 새롭게 전화거는것과 같다
				response.sendRedirect(viewPage);
			}
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (InstantiationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalArgumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (NoSuchMethodException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SecurityException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
//		if(uri.equals("/blood.do")) {
//			System.out.println("혈액형 담당 컨트롤러에게 전달예정");
//			BloodController controller = new BloodController();
//			controller.execute(request, response);
//			
//			//5단계) 결과가 있을 경우 포워딩, 결과가 없을 경우 redirect(재접속)
//			RequestDispatcher dis= request.getRequestDispatcher("/blood/result.jsp");
//			dis.forward(request, response);//전달
//		}else if(uri.equals("/movie.do")) {
//			System.out.println("영화 담당 컨트롤러에게 전달예정");
//			MovieController controller = new MovieController();
//			controller.handle(request, response);
//			
//			//5단계) 결과가 있을 경우 포워딩, 결과가 없을 경우 redirect(재접속)
//			RequestDispatcher dis= request.getRequestDispatcher("/movie/result.jsp");
//			dis.forward(request, response);//전달
//		}
		
		
	}
	
	//서블릿이 소멸될때 호출되는 생명주기 메서드
	public void destroy() {
		//주로 자원을 닫는 코드를 작성..
		if(fis!=null) {
			try {
				fis.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
}