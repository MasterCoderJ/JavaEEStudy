<%@page import="com.jspshop.exception.PimgException"%>
<%@page import="com.jspshop.exception.ColorException"%>
<%@page import="com.jspshop.exception.PsizeException"%>
<%@page import="com.jspshop.repository.PsizeDAO"%>
<%@page import="com.jspshop.repository.PimgDAO"%>
<%@page import="com.jspshop.repository.ColorDAO"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.jspshop.util.MessageObject"%>
<%@page import="com.jspshop.exception.ProductException"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@page import="com.jspshop.mybatis.MybatisConfig"%>
<%@page import="com.jspshop.repository.ProductDAO"%>
<%@page import="com.jspshop.util.FileManager"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.jspshop.domain.Pimg"%>
<%@page import="com.jspshop.domain.Color"%>
<%@page import="com.jspshop.domain.Psize"%>
<%@page import="com.jspshop.domain.Category"%>
<%@page import="com.jspshop.domain.Product"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="java.io.File"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page contentType="application/json;charset=UTF-8"%>
<%!
	int maxSize = 5 * (1024 * 1024);
	String path = "/data/";
	MybatisConfig mybatisConfig = MybatisConfig.getInstance();
	ProductDAO productDAO = new ProductDAO();
	ColorDAO colorDAO = new ColorDAO();
	PimgDAO pimgDAO = new PimgDAO();
	PsizeDAO psizeDAO = new PsizeDAO();
	
	%>
	
<%
	DiskFileItemFactory factory = new DiskFileItemFactory();//업로드 설정정보 객체
	path = application.getRealPath(path);//실제 경로로 대체
	System.out.println(path);//비동기 요청이므로 서버에 로그 찍자!!
	
	//파일 업로드 요청이 있으므로 업로드 라이브러리를 활용해야한다
	factory.setSizeThreshold(maxSize);
	factory.setRepository(new File(path));
	
	ServletFileUpload upload = new ServletFileUpload(factory);
	
	//클라이언트의 요청 분석
	
	List<FileItem> itemList = upload.parseRequest(request);
	
	//클라이언트의 파라미터 종류와 이름에따라 적절한 DTO에 담자
	Product product = new Product();
	List<Psize> psizeList = new ArrayList<Psize>();
	List<Color> colorList = new ArrayList<Color>();
	List<Pimg> pimgList = new ArrayList<Pimg>();
	
	//product에 넣기
	product.setPsizeList(psizeList);
	product.setColorList(colorList);
	product.setPimgList(pimgList);
	
	for (int i = 0;i<itemList.size(); i++) {
		FileItem item = itemList.get(i);
		if (item.isFormField()) {
			if (item.getFieldName().equals("category_idx")) {//카테고리인지
				Category category = new Category();
				category.setCategory_idx(Integer.parseInt(item.getString()));
				product.setCategory(category);
			} else if (item.getFieldName().equals("product_name")) {
				product.setProduct_name(item.getString("utf-8"));
			} else if (item.getFieldName().equals("brand")) {
				product.setBrand(item.getString("utf-8"));
			} else if (item.getFieldName().equals("price")) {
				product.setPrice(Integer.parseInt(item.getString()));
			} else if (item.getFieldName().equals("discount")) {
				product.setDiscount(Integer.parseInt(item.getString()));
			} else if (item.getFieldName().equals("size[]")) {
				//넘어온 데이터가 배열인 경우 쉼표로 구분되어 전송된다, 이를 다시 쉼표 기준으로 나누어준다
				String[] psize = item.getString("utf-8").split(",");
				
				for (int j = 0;j<psize.length; j++) {
						String size = psize[j];					
					
						Psize obj = new Psize();
						obj.setProduct(product);
						obj.setPsize_name(size);
				
						psizeList.add(obj);//DTO를 저 위에 리스트로 추가
					}
				
			} else if (item.getFieldName().equals("color[]")) {
				//넘어온 데이터가 배열인 경우 쉼표로 구분되어 전송된다, 이를 다시 쉼표 기준으로 나누어준다
				String[] color = item.getString("utf-8").split(",");
				
				for (int j = 0;j<color.length; j++) {
					String color_name = color[j];
					Color obj = new Color();
					obj.setProduct(product);
					obj.setColor_name(color_name);
			
					colorList.add(obj);//DTO를 저 위에 리스트로 추가
				}
				
			} else if (item.getFieldName().equals("detail")) {
				product.setDetail(item.getString("utf-8"));
			}
		} else {
	
			long time = System.currentTimeMillis();
			String ext = FileManager.getExt(item.getName());
			System.out.println("경로는"+path);
			String fileName=time+"."+ext;
			item.write(new File(path+fileName));//파일 저장
			Thread.sleep(500);
			
			Pimg pimg = new Pimg();//empty
			pimg.setProduct(product);
			pimg.setFilename(fileName);
			pimgList.add(pimg);
			
		}
	
	}
	
	
	SqlSession sqlSession = mybatisConfig.getSqlSession();
	
	//얻어진 해당 DAO에게 전달
	//트랜잭션은 총 4개의 DML로 이루어져있다
	
	
	MessageObject messageObject = new MessageObject();
	try{
		
		productDAO.setSqlSession(sqlSession);
		//[1] 세부업무 상품 등록
		productDAO.insert(product);
		
		//[2] 세부업무 상품 사이즈 등록
		psizeDAO.setSqlSession(sqlSession);
		for(Psize psize : product.getPsizeList()){
			psizeDAO.insert(psize);
		}
		
		//[3] 세부업무 상품 색상 등록
		colorDAO.setSqlSession(sqlSession);
		for(Color color : product.getColorList()){
			colorDAO.insert(color);
		}
		//[4] 세부업무 이미지 등록
		pimgDAO.setSqlSession(sqlSession);
		for(Pimg pimg : product.getPimgList()){
			pimgDAO.insert(pimg);
		}
		
		sqlSession.commit();
		
		messageObject.setCode(1);
		messageObject.setMsg("상품등록 성공!");
	}catch(ProductException e){
		sqlSession.rollback();	
		messageObject.setCode(0);
		messageObject.setMsg(e.getMessage());//우리가 만든 예외에 이미 등록실패에 쓸 메시지가 들어있다
	}catch(PsizeException e){
		sqlSession.rollback();	
		messageObject.setCode(0);
		messageObject.setMsg(e.getMessage());//우리가 만든 예외에 이미 등록실패에 쓸 메시지가 들어있다
	}catch(ColorException e){
		sqlSession.rollback();	
		messageObject.setCode(0);
		messageObject.setMsg(e.getMessage());//우리가 만든 예외에 이미 등록실패에 쓸 메시지가 들어있다
	}catch(PimgException e){
		sqlSession.rollback();	
		messageObject.setCode(0);
		messageObject.setMsg(e.getMessage());//우리가 만든 예외에 이미 등록실패에 쓸 메시지가 들어있다
	}finally{
		mybatisConfig.release(sqlSession);
	}
	
	//응답정보 gson으로 json화 하여 전송!
	Gson gson = new Gson();
	String json = gson.toJson(messageObject);
	out.print(json);
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
%>
