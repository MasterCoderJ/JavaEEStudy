package gallery.util;

//파일과 관련된 유용한 기능을 모아놓는, 유틸클래스
public class FileManager {
	
	// 정해진 경로를 이용하여 확장자 추출
	public static String getExt(String path) {
		int index= path.lastIndexOf(".");
			
		
		return path.substring(index+1,path.length());
	}

	public static void main(String[] args) {
		System.out.println("text.babo.aa.jpg");
	}
}
