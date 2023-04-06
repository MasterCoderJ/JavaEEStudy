<%@page contentType="text/html;charset=utf-8"%>
<%@page import="java.sql.*"%>

<%!
Connection con;
PreparedStatement pstmt;
String url="jdbc:oracle:thin:@localhost:1521:XE";
String user="java";
String pass="1234";
%>

<%
    request.setCharacterEncoding("utf-8");

    String title = request.getParameter("title");
    String writer = request.getParameter("writer");
    String content = request.getParameter("content");

    out.print(title+"<br>");
    out.print(writer+"<br>");
    out.print(content+"<br>");

    out.print("insert.jsp 동작");

    Class.forName("oracle.jdbc.driver.OracleDriver");

    con=DriverManager.getConnection(url,user,pass);
    
    String sql="insert into board(board_idx, title, writer, content)";
    sql+=" values(seq_board.nextval, ?, ?, ?)";
    pstmt = con.prepareStatement(sql);
    pstmt.setString(1,title);
    pstmt.setString(2,writer);
    pstmt.setString(3,content);

    int result = pstmt.executeUpdate();

    if(result>0){
        out.print("<script>");
        out.print("alert('입력성공');");
  
        out.print("location.href='/boardMain/boardlist.jsp';");
        out.print("</script>");
    }
    con.close();
    pstmt.close();
%>