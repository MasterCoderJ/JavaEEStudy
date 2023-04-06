
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	//이 request는 새로운 요청에 의해 생성된  request가 아니라 bloodController에게 요청을 시도할 때 생성된
	//이전의 request객체이다. 죽지않고 살아왔음
	String msg =(String)request.getAttribute("msg");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
 	혈액형 분석 결과:
 	<p>
 <%=msg %>
 	
</body>
</html>