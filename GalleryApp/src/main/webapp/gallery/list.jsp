<%@page import="gallery.domain.Gallery"%>
<%@page import="java.util.List"%>
<%@page import="gallery.repository.GalleryDAO"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="gallery.util.PageManager"%>
<%!
	PageManager pageManager= new PageManager();
	GalleryDAO galleryDAO= new GalleryDAO();
%>
<%
	List<Gallery> galleryList= galleryDAO.selectAll();
	pageManager.init(galleryList, request);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table width="100%" border="1px">
	<%int curPos= pageManager.getCurPos();%>
	<%int num= pageManager.getNum(); %>
	<%for(int i=1; i<pageManager.getPageSize(); i++){ %>
	<%if(num<1)break; %>
	<% Gallery gallery= galleryList.get(curPos++); %>
		<tr>
			<td><%=num--%></td>
			<td><img src="/data/<%=gallery.getFilename()%>" width="50px"></td>
			<td><a href="/gallery/content.jsp?gallery_idx=<%=gallery.getGallery_idx() %>">제목</a></td>
			<td><%=gallery.getWriter() %></td>
			<td><%=gallery.getRegdate()%></td>
			<td><%=gallery.getHit()%></td>
		</tr>
		<%}%>
		<tr>
			<td colspan="6">
				<button onclick="location.href='/gallery/regist.jsp';">글 등록</button>
			</td>
		</tr>
	</table>

</body>
</html>