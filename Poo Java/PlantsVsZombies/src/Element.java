/*
 * Cedric Dos Reis 
 * 14.01.2018
 * POO Java - Plants vs Zombies
 */
import java.awt.*;
import java.awt.image.ImageObserver;

import org.omg.PortableServer._ServantActivatorStub;

public class Element {
	Point location; // position sur le jpanel
	Dimension size; 
	Image img; // image dawed
	float speed; // vertical seed
	
	public Element(Point _location, Dimension _size, Image _img, float _speed) {
		location = _location;
		size = _size;
		img = _img;
		speed = _speed;
	}
	
	public void Update(long _elapsedTime) {
		System.out.println(_elapsedTime);
		if (speed != 0.0) {	
			System.out.println("MOVVEEE");
			this.location.x += speed * _elapsedTime;
		}
	}
	public Point getLocation() {
		return this.location;
	}
	public void paintComponent(Graphics g) {
		Point newLocation = new Point(
				(int) (location.x - size.getWidth() / 2),
				(int) (location.y - size.getHeight() / 2));
		g.drawImage(img,newLocation.x, newLocation.y,size.width, size.height,null); 		
	}
	
}
