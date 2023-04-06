package com.edu.noticeapp.repository;
import java.sql;
import java.util.ArrayList;
import com.edu.noticeapp.domain.Notice;

public class NoticeDAO{
	String url="jdbc:oracle:thin:@localhost:1521:XE";
	String user="jsp";
	String pass="1234";

	public int insert(Notice notice){
		int result=0;
		Connection con= null;
		PreparedStatement pstmt=null;
		
		try{
			Class.forName("oracle.jdbc.driver.OracleDriver");
			con=DriverManager.getConnection(url,user,pass);
			
			String sql="insert into notice(notice_idx, title, writer, content)";
			sql+=" values(seq_notice.nextval, ?, ?, ?)";
			pstmt=con.prepareStatement(sql);

			pstmt.setString(1, notice.getTitle());
			pstmt.setString(2, notice.getWriter());
			pstmt.setString(3, notice.getContent());

			result=pstmt.executeUpdate();
			
		}catch(ClassNotFoundException e){
			e.printStackTrace();
		}catch(SQLException e){
			e.printStackTrace();
		}

		return result;
	}
}
