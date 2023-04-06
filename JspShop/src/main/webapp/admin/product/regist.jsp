<%@page import="com.jspshop.domain.Category"%>
<%@page import="com.jspshop.domain.Product"%>
<%@page import="java.util.Map"%>
<%@page import="java.lang.reflect.Parameter"%>
<%@page import="com.jspshop.util.FileManager"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="java.io.File"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="com.jspshop.exception.ColorException"%>
<%@page import="com.jspshop.exception.PsizeException"%>
<%@page import="com.jspshop.exception.ProductException"%>
<%@page import="com.jspshop.repository.PsizeDAO"%>
<%@page import="com.jspshop.repository.ColorDAO"%>
<%@page import="com.jspshop.repository.ProductDAO"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@page import="com.jspshop.mybatis.MybatisConfig"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%!MybatisConfig mybatisConfig = MybatisConfig.getInstance();

	ProductDAO productDAO = new ProductDAO();
	//ColorDAO colorDAO = new ColorDAO();
	//PsizeDAO psizeDAO = new PsizeDAO();
	
	//업로드 관련 설정정보를 보유할 객체
	DiskFileItemFactory factory = new DiskFileItemFactory();
	%>
<%
	request.setCharacterEncoding("utf-8");
	//파라미터 받기 ->파일을 받아야하기 때문에 아파치 파일 컴포넌트 이용
	int maxSize = 5*(1024*1024);
	String path = application.getRealPath("/data/");//상대경로 구해오기!
	factory.setSizeThreshold(maxSize);//업로드 최대 사이즈 지정
	factory.setRepository(new File(path)); //임시디렉토리 및 저장 경로 지정
	ServletFileUpload upload = new ServletFileUpload(factory);
	//업로드된 파라미터 분석
	List<FileItem> itemList=upload.parseRequest(request);
	System.out.println(itemList.get(0).getString());
	Product product = new Product();
	Category category = new Category();
	//넘어온 파라미터 수 만큼 반복문 돌면서 파라미터 분석!
	//int i=0;
	for(FileItem item:itemList){
		//i++;
		if(item.isFormField()){//텍스트 필드라면...
			
			category.setCategory_idx(Integer.parseInt(itemList.get(0).getString()));
			product.setCategory(category);
			product.setProduct_name(itemList.get(1).getString("utf-8"));
			product.setBrand(itemList.get(2).getString("utf-8"));
			product.setPrice(Integer.parseInt(itemList.get(3).getString()));
			product.setDiscount(Integer.parseInt(itemList.get(4).getString()));
			product.setDetail(itemList.get(5).getString("utf-8"));
			
		}else{//파일 컴포넌트라면..
			
			long time = System.currentTimeMillis();
			String ext = FileManager.getExt(item.getName());
			System.out.println(path);
			item.write(new File(path+time+"."+ext));//파일 저장
			Thread.sleep(500);
		}
		
		
	}



	SqlSession sqlSession = mybatisConfig.getSqlSession();
	//상품 등록이란 여러 태이블을 대상으로 DML이 수행되어야하므로
	//대표적인 트랜잭션 상황의 업무이다. 따라서 DML을 수행하는 객체인
	//DAO들은 각지 커넥션을 취등하여 업무를 하는 것이 아니라 같은 커넥션
	//내에서 DML을 수행 할 수 있도록 SqlSession을 공유하자!!!
	//따라서 SqlSession에 대한 취득을 서블릿에서 처리
	
	//setter 를 이용한 객체 주입
	productDAO.setSqlSession(sqlSession);
	//colorDAO.setSqlSession(sqlSession);
	//psizeDAO.setSqlSession(sqlSession);
	
	try {
		productDAO.insert(product);
		//colorDAO.insert(null);
		//psizeDAO.insert(null);
		sqlSession.commit();
	} catch (ProductException e) {
		sqlSession.rollback();
	} catch (ColorException e) {
		sqlSession.rollback();
	} catch (PsizeException e) {
		sqlSession.rollback();
	} finally {
		mybatisConfig.release(sqlSession);
	}
	
	//업무가 끝나면 여기서 닫기!
	mybatisConfig.release(sqlSession);
%>