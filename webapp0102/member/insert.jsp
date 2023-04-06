<%@ page contentType = "text/html;charset=UTF-8"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>

<%
/*jsp는 java기술로 작성된 페이지이자, 오직 서버에서만 실행되는 스크립트 이다.
    클라이언트의 html문서로부터 전송되어온, 파라미터들을 넘겨받아 오라클에 넣어보자, 특히 오라클에 넣을때
    기존 javaSE 시절의 연동코드를 그대로 사용하면 됨
*/

//클라이언트에서 전송된 파라미터 받기!
//내장객체 중 요청 정보를 가진 request객체 사용해야함

String id= request.getParameter("id");//id를 넘겨받자
String pass= request.getParameter("pass");
String name= request.getParameter("name");

out.print("넘어온 id는"+id);
out.print("넘어온 pass는"+pass);
out.print("넘어온 name"+name);

//넘겨받은 파라미터들(전송되어온 변수)들을 오라클에 넣기
 Class.forName("oracle.jdbc.driver.OracleDriver");
 out.print("<br>");
 out.print("드라이버 로드 성공");

 String url= "jdbc:oracle:thin:@localhost:1521:XE";
 String user="javase";
 String pwd="1234";

 Connection con = DriverManager.getConnection(url,user,pwd);
 if(con != null){
    out.print("접속성공");
 }else{
    out.print("접속 실패");
 }

 String sql ="insert into member2(member2_idx, id, pass, name)";
 sql+=" values(seq_member2.nextval, ?, ?, ?)";

 PreparedStatement pstmt = null;
 pstmt = con.prepareStatement(sql);
 pstmt.setString(1,id); //넘겨받은 id
 pstmt.setString(2,pass); //넘겨받은 pass
 pstmt.setString(3,name); //넘겨받은 name

 int result = pstmt.executeUpdate(); //DML

 if(result > 0){
    out.print("가입성공");
 }
 pstmt.close();
 con.close();
%>