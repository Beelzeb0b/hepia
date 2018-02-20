/*
 * Cedric Dos Reis 
 * 14.01.2018
 * POO Java - Plants vs Zombies
 */
import java.awt.Graphics;
import java.util.ArrayList;

public class Drawer extends Thread {
	
	private Graphics graphics;
	private Game game;
	private int width;
	private int height;
	
	public Drawer(Game _game, Graphics _graphics, int _width, int _height) {
		super();
		this.graphics = _graphics;
		this.game = _game;
		this.width = _width;
		this.height = _height;
		this.run();
	}
	
	@Override
	public void run() {
		while(!game.GameOver) {
			graphics.clearRect(0, 0, width, height); // clear panel
			game.window.paintComponents(null);
			for (Entity e : game.GetElements()) {
				e.paintComponent(graphics);
			} 
			
			try {
				sleep(100);
			} catch (InterruptedException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		}
	}
	
}
