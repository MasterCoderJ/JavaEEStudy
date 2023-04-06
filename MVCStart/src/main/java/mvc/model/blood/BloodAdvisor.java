package mvc.model.blood;

public class BloodAdvisor {
	
	public String getAdvise(String blood) {
		
		String msg= null;
		
		if(blood.equals("A")) {
			msg="A형이넹";
		}else if(blood.equals("B")) {
			msg="B형이넹";
		}else if(blood.equals("O")) {
			msg="O형이넹";
		}else if(blood.equals("AB")) {
			msg="AB형이넹";
		}
		return msg;
	}

}
