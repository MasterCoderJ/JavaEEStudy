<%@page import="board.domain.Board"%>
<%@page import="board.util.PageManager"%>
<%@page import="java.util.List"%>
<%@page import="board.repository.BoardDAO"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%!BoardDAO boardDAO = new BoardDAO();
	PageManager pm = new PageManager();%>
<%
List<Board> boardList = boardDAO.selectAll();
out.print(boardList.size());

pm.init(boardList, request); //페이징 계산
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="/inc/header_link.jsp"%>
</head>
<body>
	<div class="container-fluid mt-2">
		<table class="table table-dark table-hover">
			<thead>
				<tr>
					<th>NO</th>
					<th>Image</th>
					<th>제목</th>
					<th>작성자</th>
					<th>조회수</th>
					<th>등록일</th>
				</tr>
			</thead>
			<tbody>
				<%
				int num = pm.getNum();
				int curPos = pm.getCurPos();
				%>
				<%
				for (int i = 1; i < pm.getPageSize(); i++) {
				%>
				<%
				if (num < 1)
					break;
				%>
				<%
				Board board = boardList.get(curPos++);
				%>
				<tr>
					<td width="5%"><%=num--%></td>
					<td width="15%"><img src="/data/<%=board.getFilename()%>"></td>
					<td width="50%">
						<a href="/board/content.jsp?board_idx=<%=board.getBoard_idx()%>"><%=board.getTitle()%></a>
					</td>
					<td width="5%"><%=board.getWriter()%></td>
					<td width="5%"><%=board.getRegdate().substring(0, 10)%></td>
					<td width="10%"><%=board.getHit()%></td>
				</tr>
				<%
				}
				%>
				<tr>
					<td colspan="6">
						<button class="btn btn-warning">글등록</button>
					</td>
				</tr>
			</tbody>
		</table>
		<ul class="pagination">
			<li class="page-item"><a class="page-link" href="#">Prev</a></li>
			<%
			for (int i = pm.getFirstPage(); i <= pm.getLastPage(); i++) {
				if (i > pm.getTotalPage())
					break;
			%>
			<li class="page-item<%if (i == pm.getCurrentPage()) {%> active<%}%>"><a
				class="page-link" href="/board/list.jsp?currentPage=<%=i%>"><%=i%></a></li>
			<%
			}
			%>
			<li class="page-item"><a class="page-link" href="#">Next</a></li>
		</ul>
	</div>

</body>
</html>