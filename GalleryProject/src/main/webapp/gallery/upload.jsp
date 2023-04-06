<%@page import="gallery.domain.Gallery"%>
<%@page import="gallery.repository.GalleryDAO"%>
<%@page import="java.io.File"%>
<%@page import="gallery.util.FileManager"%>
<%@page import="java.io.IOException"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%!
	GalleryDAO galleryDAO= new GalleryDAO();
%>>
<%
	//파라미터를 받아 오라클에 넣기
	request.setCharacterEncoding("utf-8");

	//클라이언트가 파일을 포함하여, 인코딩된 형식으로 요청을 시동할때는 기존에 텍스트 파라미터를 받을때 사용하는
	//getParameter()메서드로는 바이너리 파일을 포함한 기타 파라미터도 받을 수 없다
	//해결책) 업로드 라이브러리 이용해야함
	//우리가 서블릿에서 사용했던 ServletContext 인터페이스는 jsp에서 내장객체로 지원을 하고 있다, 따라서 서블릿을 할 줄 모르는 개발자는
	//내장객체를 이용할 수 있다

	String savePath= application.getRealPath("/data/");

	int maxSize=1024*1024*5;//5MB제한
	MultipartRequest multi= null;
	
	try{
	multi= new MultipartRequest(request, savePath, maxSize, "utf-8");
	
	//이미 생성자에서 업로드가 완료 되었기 때문에, 생성된 파일을 대상으로 파일명을 바꾸자
	//업로드 된 파일의 래퍼런스 얻기
	File file= multi.getFile("file");
	long time=System.currentTimeMillis();//파일명에 상용할 숫자
	String ext= FileManager.getExt(file.getName());
	
	file.renameTo(new File(savePath+time+"."+ext));
	
	String title= multi.getParameter("title");
	String writer= multi.getParameter("writer");
	String content= multi.getParameter("content");
	
	//DTO에 담기
	Gallery gallery= new Gallery();
	gallery.setTitle(title);
	gallery.setWriter(writer);
	gallery.setContent(content);
	gallery.setFilename(time+"."+ext);
	
	//dao insert호출
	int result= galleryDAO.insert(gallery);
	
	out.print("<script>");
	if(result>0){
		out.print("alert('업로드 성공');");
		out.print("location.href='/gallery/list.jsp';");
	}
	out.print("</script>");
	}catch(IOException e){
		out.print("<script>");
		out.print("alert('업로드 실패');");
		out.print("파일의 크기는 5MB이하로 해주세요");
		out.print("history.back();");
		out.print("</script>");
	}
	
	
%>>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>