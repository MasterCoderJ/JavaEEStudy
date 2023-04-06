<%@page import="java.util.List"%>
<%@page import="gallery.util.PageManager"%>
<%@page import="gallery.domain.Gallery"%>
<%@page import="gallery.repository.GalleryDAO"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%!GalleryDAO galleryDAO = new GalleryDAO();%>
<%
String gallery_idx = request.getParameter("gallery_idx");

Gallery gallery = galleryDAO.select(Integer.parseInt(gallery_idx));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script>

function edit(){
	if(confirm("수정하시겠어요?")){
		$("form").attr("method","post");
		
		if(true){
			$("form").attr("action","/gallery/edit");
			$("form").attr("enctype","multipart/form-data")
		}else{
			$("form").attr("action","/gallery/update");
		}
	}
	$("form").submit();
	
}

function del(){
	if(confirm("삭제하시겠어요?")){
		$("form").attr({
			"action":"/gallery/del",
			"method":"post"
		});
		$("form").submit();
	}
}

	$(function(){
		
		$($("input[type='button']")[0]).click(function(){
			edit();
		});

		
		$($("input[type='button']")[1]).click(function(){
			del();
		});
		
		$($("input[type='button']")[2]).click(function(){
			location.href="/gallery/list.jsp";
		});

		
	});

</script>
</head>
<body bgcolor="yellow">
	<form>
		<input type="hidden" value="<%=gallery.getGallery_idx()%>" name="gallery_idx">
		<input type="hidden" value="<%=gallery.getFilename()%>" name="filename">
		<table>
			<tr>
				<td><input type="text" name="title"
					value="<%=gallery.getTitle()%>"></td>
			</tr>

			<tr>
				<td><input type="text" name="writer"
					value="<%=gallery.getWriter()%>"></td>
			</tr>


			<tr>
				<td><textarea name="content"><%=gallery.getContent()%></textarea></td>
			</tr>

			<tr>
				<td><img src="/data/<%=gallery.getFilename()%>" width="50px"></td>
			</tr>


			<tr>
				<td><input type="file" name="file"></td>
			</tr>

			<tr>
				<td>
				<input type="button" value="수정"> 
				<input type="button" value="삭제">
				<input type="button" value="목록">
				
				</td>
			</tr>

		</table>
	</form>


</body>
</html>