
public class PileTest {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		Pile<String> maPile = new Pile<String>();
		
		maPile.empiler("guil");
		try{
			System.out.println("Depile");
			System.out.println(maPile.depiler());
			System.out.println(maPile.depiler());
		}catch (Exception e){
			System.out.println("Error");
			System.out.println(e.getMessage());
		}

	}

}
