package mvc.model.movie;

public class MovieAdvisor {

	public String getMovieAdvice(String movie) {
		
		String msg= null;
		
		if(movie.equals("batman")) {
			msg="배트맨이다";
		}else if(movie.equals("superman")) {
			msg="슈퍼맨이다";
		}else if(movie.equals("spiderman")) {
			msg="스파이더맨이다";
		}else if(movie.equals("antman")) {
			msg="앤트맨이다";
		}
		
		return msg;
	}
}
