package empapp.domain;

import java.util.List;

import lombok.Data;

@Data
public class Dept {
	private int deptno;
	private String dname;
	private String loc;
	private List<Emp>empList;//mybatis의 컬렉션을 사용하기 위해
}
