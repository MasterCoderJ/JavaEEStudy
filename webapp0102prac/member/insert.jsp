<%@ page contentType = "text/html; charset= utf-8%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>

<%
String id = request.getParameter("id");
String pass = request.getParameter("pass");
String name = request.getParameter("name");

out.print("넘어온 id :" +id);
out.print("넘어온 pass :" +pass);
out.print("넘어온 name :" +name);

Class.forName("oracle.jdbc.driver.OracleDriver");
out.print("<br>");
out.print("드라이버 로드 성공");

String url = "jdbc:oracle:thin:!@localhost:1521:XE";
String user = "java";
String pwd = "1234";

Connection con = DriverManager.getConnection(url. user, pwd);
if(con != null){
    out.print("접속 성공");
}else{
    out.pirnt("접속 실패");
}

String sql = "insert into member2(member2_idx, id, pass, name)";
sql+=" values(seq_member2.nextval, ?, ?, ?)";

PreparedStatement pstmt = null;
pstmt = con.preapreStatement(sql);
pstmt.setString(1,id);
pstmt.setString(2,pass);
pstmt.setString(3,name);

int result = pstmt.executeUpdate();

if(result >0 ){
    out.print("가입성공");
}
pstmt.close();
con.close();

%>