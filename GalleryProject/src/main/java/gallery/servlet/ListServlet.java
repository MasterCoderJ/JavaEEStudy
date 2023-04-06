package gallery.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import gallery.domain.Gallery;
import gallery.repository.GalleryDAO;
import gallery.util.PageManager;

//list.jsp를 완전히 대체할 서블릿을 정의한다
public class ListServlet extends HttpServlet{
	GalleryDAO galleryDAO= new GalleryDAO();
	PageManager pageManager;
	
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<Gallery> galleryList= galleryDAO.selectAll();
		pageManager.init(galleryList, request);
		
		//html디자인을 서블릿에서 처리한다는 것은, 유지보수성이 너무 저하된다, 이를 대체할 기술 -->JSP
	}
}
