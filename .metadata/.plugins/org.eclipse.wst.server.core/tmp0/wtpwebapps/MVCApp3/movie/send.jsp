<%@ page contentType="text/html; charset=UTF-8"%>

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
			<option value="소울">소울</option>
			<option value="드래곤길들이기">드래곤길들이기</option>
			<option value="겨울왕국">겨울왕국</option>
			<option value="알라딘">알라딘</option>
		</select>
	</form>
	<p>
	<button type="button" onClick="send()">결과보기</button>
</body>
</html>