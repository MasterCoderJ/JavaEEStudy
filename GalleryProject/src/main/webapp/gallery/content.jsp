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
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script>
	function del() {
		if (confirm("삭제하시겠어요?")) {
			//삭제 요청을 받는 서버츨 기술은 디자인이 요구되지 않으므로, 서블릿으로 처리해도 무방(공부목적)
			//폼태그 전송시 개발자가 아무것도 명시하지 않으면, 텍스트 전송을 하게 되며, 텍스트 전송에 사용되는 인코딩 타입은
			//application/x-www-form-urlencode, 이 방식은 바이너리 파일은 전송불가
			//따라서 개발자가 파일도 함께 전송하려면, form태그의 전송 인코딩 방식을 multipart/form-data로 바꿔야함
			$("form").attr({
				"action" : "/gallery/del",
				"method" : "post"
			});
			$("form").submit();
		}
	}

	function edit() {
		if (confirm("수정하시겠어요?")) {
			$("form").attr("method", "post");
			let v= $("input[type='file']").val();
			
			if (v.length>0) {//이미지 업로드하기를 원하는경우
				$("form").attr("action","/gallery/edit");
				$("form").attr("enctype","multipart/form-data")
			
			} else {//텍스트 수정만 원하는경우
				$("form").attr("action","/gallery/update");
			}
			$("form").submit();
		}
	}

	$(function() { //onload
		$($("input[type='button']")[0]).click(function() {
			edit();
		});

		$($("input[type='button']")[1]).click(function() {
			del();
		});
		
		$($("input[type='button']")[2]).click(function() {
			location.href="/gallery/list.jsp";
		});


	});
</script>

</head>
<body bgcolor="yellow">
	<form>
		<input type="hidden" value=<%=gallery.getGallery_idx()%>
			name="gallery_idx"> <input type="hidden"
			value=<%=gallery.getFilename()%> name="filename">
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
				<td><textarea placeholder="내용 입력" name="content"><%=gallery.getContent()%></textarea></td>
			</tr>

			<tr>
				<td><img src="/data/<%=gallery.getFilename()%>" width="50px"></td>
			</tr>

			<tr>
				<td><input type="file" name="file"></td>
			</tr>


			<tr>
				<td><input type="button" value="수정"> <input
					type="button" value="삭제"> <input type="button" value="목록">
				</td>
			</tr>

		</table>
	</form>


</body>
</html>