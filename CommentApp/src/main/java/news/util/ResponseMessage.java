package news.util;

//jsp가 아닌 서블릿으로 응답데이터를 만드는게 너무 귀찮아서
public class ResponseMessage {
	
	public static String getMessageURL(String msg, String url) {
		StringBuilder sb= new StringBuilder();
		sb.append("<script>");
		sb.append("alert('"+msg+"');");
		sb.append("location.href='"+url+"';");
		sb.append("</script>");
		return sb.toString();
	}
	
	public static String getMessageBack(String msg) {
		StringBuilder sb= new StringBuilder();
		sb.append("<script>");
		sb.append("alert('"+msg+"');");
		sb.append("history.back();");
		sb.append("</script>");
		return sb.toString();
	}

	
	
}
