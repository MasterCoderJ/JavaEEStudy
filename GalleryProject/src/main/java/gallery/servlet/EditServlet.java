package gallery.servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;

import gallery.domain.Gallery;
import gallery.repository.GalleryDAO;
import gallery.util.FileManager;

//이미지 파일을 포함한 글 수정
public class EditServlet extends HttpServlet {
	ServletContext context;// jsp에선 applicarion 내장객체이다
	String savePath;
	int maxSize = 1024 * 1024 * 5;
	GalleryDAO galleryDAO = new GalleryDAO();

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=utf-8");
		context= request.getServletContext();
		savePath = context.getRealPath("/data/");

		// 생성자 호출에 의해 이미 업로드 완료
		MultipartRequest multi = new MultipartRequest(request, savePath, maxSize, "utf-8");
		String gallery_idx = multi.getParameter("gallery_idx");
		String title = multi.getParameter("title");
		String writer = multi.getParameter("writer");
		String content = multi.getParameter("content");
		String filename = multi.getParameter("filename");

		// 파일 삭제
		File file = new File(savePath + filename);
		if (file.delete()) {
			// 이미 업로드 된 이미지명을 rename처리
			File file2 = multi.getFile("file");

			long time = System.currentTimeMillis();
			String ext = FileManager.getExt(file2.getName());
			boolean flag = file2.renameTo(new File(savePath + time + "." + ext));

			if (flag) {
				// db수정
				Gallery gallery = new Gallery();
				gallery.setGallery_idx(Integer.parseInt(gallery_idx));
				gallery.setTitle(title);
				gallery.setWriter(writer);
				gallery.setContent(content);
				gallery.setFilename(time+"."+ext); // 바뀐이름 적용

				int result = galleryDAO.update(gallery);// 업데이트 실행
				PrintWriter out = response.getWriter();
				// 이미 업로드 된 파일의 이름변경
				out.print("<script>");
				if (result > 0) {
					out.print("alert('수정성공');");
					out.print("location.href='/gallery/content.jsp?gallery_idx="+gallery_idx+"';");
				} else {
					out.print("alert('수정실패');");
					out.print("history.back();");
				}
				out.print("</script>");
			}

		}

	}
}
