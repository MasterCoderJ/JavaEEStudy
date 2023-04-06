<%@page import="gallery.domain.Gallery"%>
<%@page import="gallery.repository.GalleryDAO"%>
<%@page import="gallery.util.FileManager"%>
<%@page import="java.io.File"%>
<%@page import="java.io.IOException"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%!
	GalleryDAO galleryDAO= new GalleryDAO();
%>>
<%
	request.setCharacterEncoding("utf-8");

	String savePath= application.getRealPath("/data/");

	int maxSize= 1024* 1024* 5;
	MultipartRequest multi;

	try{
	multi= new MultipartRequest(request, savePath, maxSize,"utf-8");
	
	//이미 생성자에서 업로드가 완료되었기 때문에, 생성된 파일을 대상으로 파일명을 바꾸자
	File file= multi.getFile("file"); //html에서의 컴포넌트 이름. 업로드된 파일 래퍼런스 얻기
	
	long time=System.currentTimeMillis();
	String ext= FileManager.getExt(file.getName());
	file.renameTo(new File(savePath+time+"."+ext));
	String title= multi.getParameter("title");
	String writer= multi.getParameter("writer");
	String content= multi.getParameter("content");
	
	//DTO에담기
	Gallery gallery= new Gallery();
	
	gallery.setTitle(title);
	gallery.setWriter(writer);
	gallery.setContent(content);
	gallery.setFilename(time+"."+ext);
	
	int result= galleryDAO.insert(gallery);
	
	out.print("<script>");
	if(result>0){
		out.print("alert('등록완료');");
		out.print("location.href='/gallery/list.jsp';");
	}
	out.print("</script>");
	
	}catch(IOException e){
		out.print("<script>");
		out.print("파일의 크기는 5MB이하로 제한");
		out.print("history.back();");
		out.print("</script>");
	}
%>