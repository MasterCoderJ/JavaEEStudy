<%@page import="member.domain.Member"%>
<%@page contentType="text/html;charset=utf-8"%>
<%
	Member member=(Member)session.getAttribute("member");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>갤러리 등록</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript">
	//이미지 미리보기
	function preview(file){//매개변수로 유저가 선택한 파일정보가 넘어옴
		console.log("넘겨받은 파일정보",file);
		//자바스크립트로 파일에 대한 스트림 객체가 지원된다
		let reader= new FileReader();
		
		reader.readAsDataURL(file);//파일 읽기
		
		//파일이 모두 로드 되면
		reader.onload= function(e){
			console.log("로드 정보",e);
			$("#pic").attr("src",e.target.result);//pic의 attr(속성)에 src에 대입하면 된다
			$("#pic").show();
			
		};
	}
	
	function regist() {
		//서버에 파일(바이너리 형식 파일)을 포함한 폼을 전송한다!!
		$("form").attr({
			"action" : "/gallery/upload.jsp",
			"method" : "post",
			"enctype" : "multipart/form-data" //폼양식에 바이너리 파일이 포함된 경우 반드시!!지정 암기
		});

		$("form").submit();

	}

	$(function() { //onload
		$("#pic").hide();
	
		//파일 컴포넌트의 값을 유저가 변경하면...
		$("input[type='file']").on("change", function(e){
			//console.log("파일정보", this.files);
			preview(this.files[0]);//미리보기 구현 함수에게 파일정보 전달
			
		});
	
		$($("input[type='button']")[0]).click(function() {
			regist();
		});

		$($("input[type='button']")[1]).click(function() {

		});

	});
</script>
</head>
<body>
	<form>
		<table>
			<tr>
				<td>
				<%if(member==null){ %>
					<input type="text" placeholder="작성자입력" name="title">
					<%}else{ %>
					<input type="text" value="<%=member.getName()%>" name="title">
					<%} %>
				</td>
			</tr>

			<tr>
				<td><input type="text" placeholder="작성자 입력" name="writer"></td>
			</tr>


			<tr>
				<td><textarea placeholder="내용 입력" name="content"></textarea></td>
			</tr>

			<tr>
				<td><input type="file" name="file"></td>
			</tr>
			
			<tr>
				<td>
					<img src="#" width="250px" id="pic">
				</td>
			</tr>
			

			<tr>
				<td><input type="button" value="등록"> <input
					type="button" value="목록"></td>
			</tr>

		</table>
	</form>

</body>
</html>