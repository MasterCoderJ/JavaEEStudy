<%@ page contentType="text/html;charset=UTF-8"%>
<%
	//여기서 request는 새로운 요청에 의해서 생성된 request가 아닌 BloodController에게 요청을 시도할 때 생성된 객체이다
	//즉, 죽지 않고 여기까지 살아온것이다
		
	String msg= (String)request.getAttribute("msg");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	영화에 대한 판단 결과:
	<p>
		<%=msg%>
	</p>
</body>
</html>