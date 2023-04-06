<%@page contentType="text/html;charset=utf-8"%>
<%@page import="com.edu.noticeapp.repository.NoticeDAO"%>
<%@page import="com.edu.noticeapp.domain.Notice"%>

<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
        body {
            font-family: Arial, Helvetica, sans-serif;
        }

        * {
            box-sizing: border-box;
        }

        input[type=text],
        select,
        textarea {
            width: 100%;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            margin-top: 6px;
            margin-bottom: 16px;
            resize: vertical;
        }

        input[type=button] {
            background-color: #04AA6D;
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        input[type=button]:hover {
            background-color: #45a049;
        }

        .container {
            border-radius: 5px;
            background-color: #f2f2f2;
            padding: 20px;
        }
    </style>
    <script src="https://cdn.ckeditor.com/ckeditor5/35.4.0/classic/ckeditor.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <script>
		
    </script>
</head>

<body>

    <h3>상세보기</h3>

    <div class="container">
        <form method="post" action="/notice/regist.jsp">

            <input type="text"  name="title" value="<%=notice.getTitle()%>">

            <input type="text"  name="writer" value="<%=notice.getWriter()%>">

            <textarea id="content" name="content" placeholder="Write something.." style="height:200px"><%=notice.getContent()%></textarea>
            <!--submit은 현재 form태그의 내용을 무조건 전송하므로 무조건 전송을 방지하기 위해 일반 button-->
            <input type="button" value="수정">
			<input type="button" value="삭제">
			<input type="button" value="목록">
        </form>
    </div>

</body>

</html>