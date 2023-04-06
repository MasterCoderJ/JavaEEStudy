<%@page contentType="text/html;charset=utf-8"%>
<%
    //색상배열
    String[] bgArray={"red","orange","yellow","green","blue","navy","purple"};

    //클라이언트의 파라미터 넘겨받기, 웹상으로 전송된 모든 파라미터는 문자열이다.
    //심지어 숫자형으로 넘겨도 문자로 취급
    String bg= request.getParameter("bg");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script>
        //서버에 bg.jsp라는 jsp에 파라미터 전송, get방식으로 보내도 된다. 보안상 중요하지 않고 양이 많지 않기 때문에..
        //마치 편지봉투에 간단히 메시지 적는것과 같다, header를 타고 전송한다 생각하면 됨
        function send(){
            //선택한 셀렉트박스의 값
            let combo = document.getElementById("combo");
            location.href="/bg.jsp?bg="+combo.value;
        }
    </script>
</head>
<body bgcolor="<%=bg%>">
    <select name="combo" id="combo">
        <%for(int i=0; i<bgArray.length; i++){%>
        <option value="<%=bgArray[i]%>"><%=bgArray[i]%></option>
        <%}%>
    </select>

    <button onclick="send()">배경변경</button>
    
</body>
</html>