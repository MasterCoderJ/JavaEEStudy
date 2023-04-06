<%@page contentType="text/html;charset=utf-8"%>
<%@page import="java.sql.*"%>

<%! //선언부
    String url= "jdbc:oracle:thin:@localhost:1521:XE";
    String user= "jsp";
    String pwd= "1234";

    Connection con;
    PreparedStatement pstmt;
    PreparedStatement pstmt2;
    ResultSet rs;

%>
<%
    out.print("등록 jsp 요청결과");

    //전송되는 파라미터들에 대한 인코딩 처리
    request.setCharacterEncoding("utf-8");

    //클라이언트가 전송한 파라미터들 받기
    String id= request.getParameter("id");
    String pass= request.getParameter("pass");

    String[] hobby_name= request.getParameterValues("hobby_name");
    String mail_receive= request.getParameter("mail_receive");

    out.print("id is "+id+"<br>");
    out.print("pass is "+pass+"<br>");

    for(int i=0; i<hobby_name.length; i++){
        out.print("hobby_name is "+hobby_name[i]+"<br>");
    }
    out.print("mail is "+mail_receive+"<br>");

    //드라이버 로드
    Class.forName("oracle.jdbc.driver.OracleDriver");
    
    //접속
    con= DriverManager.getConnection(url,user,pwd);

    //Connection객체는 디폴트가 autoCommit이 true인 상태이기 때문에 무조건 트랜잭션 commit중
    //따라서, false로 바꿔줘야함
    con.setAutoCommit(false);//자동 commit 막기
    //왜 막아야하나? 개발자가 원할때 commit해야하기 때문

    try{
        //회원가입
        StringBuilder sb = new StringBuilder();
        sb.append("insert into member(member_idx, id, pass, mail_receive)");
        sb.append(" values(seq_member.nextval, ?, ?, ?)");
        pstmt= con.prepareStatement(sb.toString());
        pstmt.setString(1,id);
        pstmt.setString(2,pass);
        pstmt.setString(3,mail_receive);

        int result= pstmt.executeUpdate(); //쿼리실행

        out.print("회원등록결과"+result);

        //취미테이블에 레코드를 넣기 위해서는, 부모 테이블은 member 테이블에
        //방금 들어간 pk를 얻어와야 한다
        sb.delete(0,sb.length());
        sb.append("select seq_member.currval as member_idx from dual");
        pstmt2=con.prepareStatement(sb.toString());
        rs=pstmt2.executeQuery();

        int member_idx=0;

        if(rs.next()){//레코드가 있다면.
            member_idx= rs.getInt("member_idx");
        }

        //사용자가 체크한 수만큼 반복문 돌리면서 insert
        sb.delete(0,sb.length()); //기존 쿼리 삭제

        for(int i=0; i<hobby_name.length; i++){
            PreparedStatement ps = null;

            sb.append("insert into hobby(hobby_idx,member_idx,hobby_name)");
            sb.append(" values(seq_hobby.nextval, ?, ?)");
            ps= con.prepareStatement(sb.toString());
            ps.setInt(1,member_idx);//foreign key
            ps.setString(2, hobby_name[i]);

            ps.executeUpdate();
            ps.close();
            sb.delete(0,sb.length());
        }
        con.commit();//트랜잭션 성공으로 확정짓기
        out.print("<script>");
            out.print("alert('가입완료');");
        
            //재접속하라
            out.print("location.href='/list.jsp';");
            out.print("</script>");
        
    }catch(Exception e){
        //에러가 발생하면, 모든 업무는 없었던 일로 돌려놓자
        con.rollback();//트랜잭션 실패로 확정짓기
    }finally{
        con.setAutoCommit(true);
    }

    pstmt.close();
    pstmt2.close();
    con.close();
%>