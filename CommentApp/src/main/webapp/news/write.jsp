<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="/inc/header_link.jsp"%>
<script src="https://cdn.ckeditor.com/ckeditor5/35.4.0/classic/ckeditor.js"></script>
<script>

	$(function(){
	    ClassicEditor
	        .create( document.querySelector('#editor'))
	        .catch( error => {
	            console.error( error );
	        });
	    
	    $($("button")[0]).click(function(){
	    	$("#form1").attr({
	    		"action":"/news/regist",
	    		"method":"post"
	    	});
	    	$("#form1").submit();
	    });
	    
	    $($("button")[1]).click(function(){
	    	location.href="list.jsp";
	    	});
	});
</script>
</head>

<body>
<div class="container mt-3">
		<div class="row text-center">
			<h3>뉴스 등록</h3>
		</div>
	
	<form id="form1">

		<table class="table mt-3 border table-hover">
			  <div class="form-group">
			    <label for="title">제목</label>
			    <input type="text" class="form-control" placeholder="제목" name="title">
			  </div>
			  
			  <div class="form-group">
			    <label for="writer">작성자:</label>
			    <input type="text" class="form-control" placeholder="작성자" name="writer">
			  </div>
			  
			 <div class="form-group" >
			  <textarea class="form-control" rows="5" name="content" id="editor"></textarea>
			</div>
			
			<div class="row mt-2 text-center">
				<div class="col">
					<button type="button" class="btn btn-primary">등록</button>
					<button type="button" class="btn btn-primary">목록</button>
				</div>
			</div>
		</table>
	</form>
</div>
	

</body>
</html>