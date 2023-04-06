<%@page contentType="text/html;charset=utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script>
        function send(){
            let t = document.getElementById("t");
            location.href="/boardMain/bg.jsp?bg="+t.value;
        }

    </script>
</head>
<%
    String bg = request.getParameter("bg");
%>

<body bgcolor="<%=bg%>">
    <input type="text" id="t">
    <button onclick="send()">OK</button>
    
</body>
</html>