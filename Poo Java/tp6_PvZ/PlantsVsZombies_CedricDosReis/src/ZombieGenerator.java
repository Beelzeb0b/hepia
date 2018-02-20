/*
 * Cedric Dos Reis 
 * 14.01.2018
 * POO Java - Plants vs Zombies
 */
import java.awt.Point;

import javax.swing.ImageIcon;
import javax.swing.text.Position;

public class ZombieGenerator extends Thread {
	private Game game;
	private long timeToSpawn = 7000;
	public ZombieGenerator (Game _game) {
		this.game = _game;
	}
	
	public void run() {
		while (!game.GameOver ) {
			try {
				sleep(timeToSpawn);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			Point p = new Point(1000, 100 + 110 * (int)(Math.random() * (5-1)+1));
			switch((int) (Math.random() * (3 - 1)+1)) {
				case 1:
					game.NewZombie(new Zombie(p, new ImageIcon("images/ZombieHD.png").getImage(), -0.000001f, 100));
					break;
				case 2:
					game.NewZombie(new Zombie(p, new ImageIcon("images/Conehead_Zombie.png").getImage(), -0.0000009f, 150));
					break;
				case 3:
					game.NewZombie(new Zombie(p, new ImageIcon("images/Buckethead_Zombie.png").getImage(), -0.0000008f, 200));
					break;
			}
		}
	}
}
