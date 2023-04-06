<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title</title>
<%@ include file="/inc/header_link.jsp"%>

<script>
	function regist(){
		$("#form1").attr({
			"action":"/board/regist",
			"method":"post",
			//default는 application/x-www-form-urlencoded
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
		//버튼에 이벤트 연결(button")
		$($("button")[0]).click(function(){
			regist();
		});
		
		$($("button")[1]).click(function(){
			alert("목록 보기");
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
					<button class="btn btn-warning">글 등록</button>
					<button class="btn btn-warning">글 목록</button>
				</div>
			</div>
		</form>
	</div>

</body>
</html>