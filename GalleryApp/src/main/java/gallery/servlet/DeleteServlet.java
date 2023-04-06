package gallery.servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import gallery.repository.GalleryDAO;

public class DeleteServlet extends HttpServlet{
	GalleryDAO galleryDAO= new GalleryDAO();
	ServletContext context; //어플리케이션의 전반적인 컨텍스트..(행위달성을 위한 부가정보)
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//요청 파라미터 받기
		response.setContentType("text/html;charset=utf-8");
		
		String gallery_idx= request.getParameter("gallery_idx");
		String filename= request.getParameter("filename");
		System.out.println("gallery_idx is"+gallery_idx);
		
		//delete gallery where gallery_idx=?
		
		//로컬 하드의 파일을 제어하기 위해서는 자바의 File클래스 사용
		context= request.getServletContext();
		String app_path= context.getRealPath("/data");
		System.out.println("현재 어플리케이션의 실제 위치는"+ app_path);
		File file= new File(app_path+"/"+ filename);
		
		PrintWriter out= response.getWriter();
		
		if(file.delete()) { //파일이 삭제되었다면
			//DB삭제 + 파일
			int result= galleryDAO.delete(Integer.parseInt(gallery_idx));
			
			out.print("<script>");
			if(result>0) {
				out.print("alert('삭제완료');");
				out.print("location.href='/gallery/list.jsp';");
			}else {
				out.print("alert('삭제실패');");
				out.print("history.back();");
			}
			out.print("</script>");
		}
		
		
	}
}
