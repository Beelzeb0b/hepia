
import java.awt.*;
public class Tp1f {

	@SuppressWarnings("deprecation")
	public static void main(String[] args) throws InterruptedException {
		Frame f = new Frame("HelloWin");
		f.setSize(200,200);
		f.setLocation(100,100);
		f.setBackground(Color.pink);
		f.setVisible(true);
		
		int Timer = 0;
		while (Timer < 10){
			Thread.sleep(1000);
			Timer++;
			f.move(f.location().x + 10,f.location().y+10);
		}
	}

}
