<%@page contentType="text/html;charset=utf-8"%>
<%@page import="com.edu.noticeapp.repository.NoticeDAO"%>
<%@page import="com.edu.noticeapp.domain.Notice"%>
<%@page import= "java.util.ArrayList"%>

<%!
	NoticeDAO noticeDAO= new NoticeDAO();
%>
<%
	ArrayList<Notice>list=noticeDAO.selectAll();
	int totalRecord= list.size();
	int pageSize=10;
	int totalPage=(int)Math.ceil((float)totlaRecord/pageSize);
	int blockSize=10;
	int currentPage=1;

	if(request.getParameter("currentPage")!=null){
		currentPage= Integer.parseInt(request.getParameter("currentPage"));
	}

	int firstPage= currentPage-(currentPage-1)%blockSize;
	int lastPage= firstPage+(blockSize-1);

	int curPos=(currentPage-1)*pageSize;
	int num= totalRecord-curPos;

%>
<script>
	$(document).ready(function(){
		$("button").on("click",function(){
			location.href="/notice/write.html";
		});
	});
</script>