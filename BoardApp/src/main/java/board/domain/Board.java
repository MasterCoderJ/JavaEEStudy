package board.domain;

import lombok.Data;

@Data
public class Board {
	
	private int board_idx;
	private String title;
	private String writer;
	private String content;

}
