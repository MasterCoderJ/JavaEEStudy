<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script type="text/javascript">
	function send(){
		form1.action="/blood.do";
		form1.method="post";
		form1.submit();
	}
</script>

</head>
<body>
	<form name="form1">
		<select name="blood">
			<option value="A">A형</option>
			<option value="B">B형</option>
			<option value="O">O형</option>
			<option value="AB">AB형</option>
		</select>
	</form>
	<p>
		<button type="button" onClick="send()">분석 요청</button>
	</p>

</body>
</html>