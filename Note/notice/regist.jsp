<%@page contentType="text/html;charset=utf-8"%>
<%@page import="com.edu.noticeapp.repository.NoticeDAO"%>
<%@page import="com.edu.noticeapp.domain.Notice"%>
<%!
	NoticeDAO noticeDAO= new NoticeDAO();
%>

<%
	Notice notice = new Notice();
	request.setCharacterEncoding("utf-8");
	notice.setTitle(request.getParameter("title"));
	notice.setWriter(request.getParameter("writer"));
	notice.setContent(request.getParameter("content"));

	int result = noticeDAO.insert(notice);

	if(result>0){
%>
	<script>
		alert("��ϿϷ�");
		location.href="/notice/list.jsp";
	</script>
	<%}else{%>
		<script>
		alert("��Ͻ���");
		history.back();
		</script>
		<%}%>