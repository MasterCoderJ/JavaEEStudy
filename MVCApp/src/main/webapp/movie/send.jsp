<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script type="text/javascript">
	
	function send(){
		//서버에 폼 전송하기
		form1.action="/movie.do";
		form1.method="post";
		form1.submit();
	}
	
</script>
</head>
<body>
	<form name="form1">
		<select name="movie">
			<option value="batman">배트맨</option>
			<option value="superman">슈퍼맨</option>
			<option value="spiderman">스파이더맨</option>
			<option value="antman">앤트맨</option>
		</select>
	</form>
	<p>
	<button type="button" onClick="send()">분석요청</button>
	</p>
</body>
</html>