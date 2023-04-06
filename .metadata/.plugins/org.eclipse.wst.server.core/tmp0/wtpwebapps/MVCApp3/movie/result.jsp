
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	String msg = (String)request.getAttribute("msg");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
 	영화 분석 결과:
 	<p>
 <%=msg %>
 	
</body>
</html>