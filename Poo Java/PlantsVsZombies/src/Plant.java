/*
 * Cedric Dos Reis 
 * 14.01.2018
 * POO Java - Plants vs Zombies
 */
import java.awt.Dimension;
import java.awt.Graphics;
import java.awt.Image;
import java.awt.Point;

public class Plant extends Element implements Entity{
	
	boolean asAttack = false;
	int life = 0;
	Box box = null;
	
	public Plant (Point _location, Image _img) {
		super( _location, new Dimension(80, 80), _img, 0);
		life = 0;
		box = null;
	}
	
	public void PutInBox(Box _case) {
		this.box = _case;
	}
}
