package board.servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import board.domain.Board;
import board.repository.BoardDAO;
import board.util.FileManager;

public class RegistServlet extends HttpServlet {
	ServletContext context;
	int maxSize = 5 * 1024 * 1024;
	String savePath;
	BoardDAO boardDAO = new BoardDAO();
	DiskFileItemFactory factory;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");

		PrintWriter out = response.getWriter();

		context = request.getServletContext();

		savePath = context.getRealPath("/data/");

		factory = new DiskFileItemFactory();
		factory.setSizeThreshold(maxSize);
		factory.setRepository(new File(savePath));

		ServletFileUpload upload = new ServletFileUpload(factory);

		try {
			List<FileItem> itemList = upload.parseRequest(request);

			Board board = new Board();
			for (FileItem item : itemList) {
				if (item.isFormField()) {
					switch (item.getFieldName()) {
					case "title":
						board.setTitle(item.getString("utf-8"));
						break;
					case "writer":
						board.setWriter(item.getString("utf-8"));
						break;
					case "content":
						board.setContent(item.getString("utf-8"));
						break;
					}
					;
				} else {
					if (item.getSize() > 0) {
						long time = System.currentTimeMillis();
						String ext = FileManager.getExt(item.getName());
						File file = new File(savePath + time + "." + ext);
						try {
							item.write(file);

							board.setFilename(time + "." + ext);
							int result = boardDAO.insert(board);

							out.print("<script>");
							if (result > 0) {
								out.print("alert('등록성공');");
								out.print("location.href='/board/list.jsp';");
							} else {
								out.print("alert('등록 실패');");
								out.print("history.back();");
							}
							out.print("</script>");
						} catch (Exception e) {
							e.printStackTrace();
						}
					}
				}

			}
		} catch (FileUploadException e) {
			e.printStackTrace();
		}

	}

}
