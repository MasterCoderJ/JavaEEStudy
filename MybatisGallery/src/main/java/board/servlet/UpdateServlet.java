package board.servlet;

import java.io.File;
import java.io.IOException;
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

public class UpdateServlet extends HttpServlet{
	BoardDAO boardDAO= new BoardDAO();
	DiskFileItemFactory factory;
	int maxSize=5*1024*1024;
	ServletContext context;
	String savePath;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		
		context= request.getServletContext();
		//설정객체
		factory= new DiskFileItemFactory();
		factory.setSizeThreshold(maxSize);
		savePath=context.getRealPath("/data/");
		
		//임시 파일 위치이자, 실제 파일이 위치할 곳
		factory.setRepository(new File(savePath));
		
		//업로드 담당객체
		ServletFileUpload upload= new ServletFileUpload(factory);
		
		//요청 분석 시작
		try {
			List<FileItem> itemList= upload.parseRequest(request);
			Board board= new Board();
			
			for(FileItem item: itemList) {
				if(item.isFormField()) {//텍스트 데이터라면
					switch(item.getFieldName()) {
					case "board_idx":board.setBoard_idx(Integer.parseInt(item.getString()));break;
					case "filename":board.setFilename(item.getString());break;
					case "title":board.setTitle(item.getString("utf-8"));break;
					case "writer":board.setWriter(item.getString("utf-8"));break;
					case "content":board.setContent(item.getString("utf-8"));break;
					}
					
				}else {
					//업로드 한 경우만..
					if(item.getSize()>0) {
						long time= System.currentTimeMillis();
						String ext=FileManager.getExt(item.getName());
						File file= new File(savePath+time+"."+ext);
						try {
							item.write(file);
							
							//기존파일 찾아서 제거
							File df= new File(savePath+board.getFilename());
							if(df.delete()) { //잘 지워졌다면
								board.setFilename(time+"."+ext);//새로운 파일명으로 대체
								
//								//DAO update();
//								boardDAO.update(board);
							}
						} catch (Exception e) {
							e.printStackTrace();
						}
					}
				}
			}
			boardDAO.update(board);
		} catch (FileUploadException e) {
			e.printStackTrace();
		}
	}
}
