/*
 * Cedric Dos Reis 
 * 14.01.2018
 * POO Java - Plants vs Zombies
 */
import java.awt.Dimension;
import java.awt.Image;
import java.awt.Point;

public class Zombie extends Element implements Entity{
	private int life;
	
	public Zombie(Point _location, Image _img, float _speed, int _life) {
		super(_location, new Dimension(70, 120), _img, _speed);
		this.life = _life;
	}
}
