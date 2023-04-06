<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>MyBatisApp</title>
<%@ include file="/inc/header_link.jsp"%>

<script type="text/javascript">

	function regist(){
		$("#form1").attr({
			"action":"/board/regist",
			"method":"post",
			"enctype":"multipart/form-data"
		});	
		$("#form1").submit();
	}
	
	$(function(){
		ClassicEditor
        .create( document.querySelector( '#content' ) )
        .catch( error => {
            console.error( error );
        } );

		$($("button")[0]).click(function(){
			regist();
		});
		
		$($("button")[1]).click(function(){
			location.href="/board/list.jsp";
		});

	});
	
</script>
</head>
<body>
	<div class="container mt-2">
		<div class="row text-center">
			<h3>글 등록</h3>
		</div>
		<form id="form1">

			<div class="row mt-2">
				<input type="text" class="form-control" placeholder="제목 입력"
					name="title">
			</div>

			<div class="row mt-2">
				<input type="text" class="form-control" placeholder="작성자 입력"
					name="writer">
			</div>

			<div class="row mt-2">
				<textarea style="width: 100%;" class="form-control" id="content"
					name="content"></textarea>
			</div>

			<div class="row mt-2">
				<input type="file" class="form-control" name="file">
			</div>

			<div class="row mt-2">
				<div class="col text-center">
					<button type="button" class="btn btn-warning">등록</button>
					<button type="button" class="btn btn-warning">목록</button>
				</div>
			</div>
		</form>
	</div>

</body>
</html>