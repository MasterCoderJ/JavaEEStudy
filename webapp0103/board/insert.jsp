<%@ page contentType="text/html;charset=utf-8"%>

<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>

<%! 
    //멤버 영역
    Connection con; 
    PreparedStatement pstmt;
    String url="jdbc:oracle:thin:@localhost:1521:XE";
    String user="javase";
    String pass="1234";
%>

<%
    /*
    클라이언트에서 전송된 파라미터를 이용하여 오라클에 넣기
    */

    //request는 내장객체이기 때문에 그 명칭이 이미 시스템에 의해 정해져있다.
    //웹상으로 전달된 모든~~데이터는 문자열 취급
    
    //전송되어온 파라미터에 대한 인코딩 지정
    request.setCharacterEncoding("utf-8");

    String title=request.getParameter("title"); //html에서의 입력양식(파라미터) 이름
    String writer=request.getParameter("writer");
    String content=request.getParameter("content");

    out.print("insert.jsp 동작함<br>");
    out.print(title+"<br>");
    out.print(writer+"<br>");
    out.print(content+"<br>");

    Class.forName("oracle.jdbc.driver.OracleDriver");
  
    con=DriverManager.getConnection(url,user,pass);
    out.print(con); //주소값이 나와야함. null이 아니라. 연결이 된다는거.
    
    String sql="insert into board(board_idx, title, writer, content)";
    sql+=" values(seq_board.nextval, ?,?,?)";

    pstmt=con.prepareStatement(sql);

    pstmt.setString(1, title );
    pstmt.setString(2,  writer);
    pstmt.setString(3, content);

    int result=pstmt.executeUpdate(); //insert는 언제나 성공 시 한건
    
    //out.print()는 서버가 클라이언트에 응답할 데이터를 모아놓는 출력 스트림이다.
    //print() 메서드에 명시한 문자열은 차곡차곡 응답객체에 쌓여있다가, 서버가 응답을 할 시점에
    //다 모아진 문자열을 클라이언트에게 전송한다.
    if(result>0){
        out.print("<script>");
        out.print("alert('입력성공');");
        //클라이언트의 브라우저로 하여금, 이 응답정보를 받은 시점에 지정한 url로 다시 들어오게 한다. 이동이 일어나는게 아님!!!
        out.print("location.href='/board/boardlist.jsp';");
        out.print("</script>");
    }

    pstmt.close();
    con.close();


%>