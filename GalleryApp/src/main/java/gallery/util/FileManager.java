package gallery.util;

public class FileManager {
	
	//정해진 경로를 이용하여 확장자 추출
	public static String getExt(String path) {	
		
		int index= path.lastIndexOf(".");
		
		return path.substring(index+1, path.length());
	}
	
	public static void main(String[] args) {
		System.out.println();
	}
}
