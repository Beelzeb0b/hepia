/*
 * Cedric Dos Reis 
 * 14.01.2018
 * POO Java - Plants vs Zombies
 */
import java.awt.Graphics;
import java.awt.Point;

public interface Entity {
	public void Update(long elapsedTime);
	public void paintComponent(Graphics g);
	public Point getLocation();
}
