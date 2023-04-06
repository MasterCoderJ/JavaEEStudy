<%@page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script>
        function send(){
            let color = document.getElementById("color");
            location.href = "/board/color.jsp?bg="+color.options[color.selectedIndex].value;
            console.log("배경값",color.options[color.selectedIndex].value);
        }
    </script>
</head>
<%
    String bg = request.getParameter("bg");
    out.print("넘어온데이타"+bg);
%>
<body bgcolor="<%=bg%>">
    <select name="color" id="color">
        <option value="red">red</option>
        <option value="orange">orange</option>
        <option value="yellow">yellow</option>
        <option value="green">green</option>
        <option value="blue">blue</option>
        <option value="navy">navy</option>
        <option value="purple">purple</option>
    </select>
    <button onclick="send()">OK</button>
</body>
</html>