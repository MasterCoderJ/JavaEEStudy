<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>갤러리</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>

<script>
	function regist() {
		$("form").attr({
			"action" : "/gallery/upload.jsp",
			"method" : "post",
			"enctype" : "multipart/form-data"
		});

		$("form").submit();
	}

	$(function() {
		$($("input[type='button']")[0]).click(function() {
			regist();

		});

	});
</script>
</head>
<body>
	<form>
		<table>
			<tr>
				<td><input type="text" placeholder="제목입력" name="title"></td>
			</tr>

			<tr>
				<td><input type="text" placeholder="작성자 입력" name="writer"></td>
			</tr>


			<tr>
				<td><textarea placeholder="내용 입력" name="content"></textarea></td>
			</tr>

			<tr>
				<td><input type="file" name="file"></td>
			</tr>


			<tr>
				<td>
				<input type="button" value="등록"> 
				<input type="button" value="목록">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>