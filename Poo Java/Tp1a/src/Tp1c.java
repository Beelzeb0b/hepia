
public class Tp1c {
	public static void main(String[] args){
		int x = (int)(Math.random()*10); // x is an integer between 0 & 10
		int y = (int)(Math.random()*10);
		System.out.println("x=" + x + " y=" + y);
		while(x<5){
			if(y<5){
				x++;
			}else{
				x--;
				y++;
			}
		}
		System.out.println("x=" + x + " y=" + y);
 	}
}
