package news.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import news.domain.News;
import news.repository.NewsDAO;
import news.util.ResponseMessage;

public class UpdateServlet extends HttpServlet{
	NewsDAO newsDAO= new NewsDAO();
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out= response.getWriter();
		
		String news_idx= request.getParameter("news_idx");
		String title= request.getParameter("title");
		String writer= request.getParameter("writer");
		String content= request.getParameter("content");
		
		News news= new News();
		news.setNews_idx(Integer.parseInt(news_idx));
		news.setTitle(title);
		news.setWriter(writer);
		news.setContent(content);
		int result= newsDAO.update(news);
		
		if(result>0) {
			out.print(ResponseMessage.getMessageURL("수정 성공", "/news/list.jsp"));
		}else {
			out.print(ResponseMessage.getMessageBack("수정 실패"));
		}
	}
}
