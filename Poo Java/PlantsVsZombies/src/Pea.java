/*
 * Cedric Dos Reis 
 * 14.01.2018
 * POO Java - Plants vs Zombies
 */
import java.awt.Dimension;
import java.awt.Graphics;
import java.awt.Image;
import java.awt.Point;
import java.util.ArrayList;

import javax.swing.ImageIcon;
import javax.swing.text.GapContent;

public class Pea extends Plant implements Entity{
	static int fireSpeed;
	long elapsedTimeFire;
	ArrayList<Projectile> projectiles;
	
	public Pea(Point _location, Image _img) {
		super(_location, _img);
		this.life = 100;
		this.asAttack = true;
		this.fireSpeed = 10000000;
		this.elapsedTimeFire =0;
		this.projectiles = new ArrayList<Projectile>();
	}
	
	@Override
	public void Update(long _elapsedTime){
		super.Update(_elapsedTime);
		elapsedTimeFire += _elapsedTime;
		if(elapsedTimeFire > fireSpeed) {
			elapsedTimeFire = 0;
			Fire();
		}
		for (Projectile p : projectiles) {
			p.Update(_elapsedTime);
		}
	}
	
	public void Fire() {
		projectiles.add(new Projectile(new Point(this.location.x, this.location.y-15), new Dimension(25, 25), new ImageIcon("images/ProjectilePea.png").getImage(), 0.00001f));
	}
	
	@Override
	public void paintComponent(Graphics g) {
		super.paintComponent(g);
		for (Projectile p : projectiles) {
			p.paintComponent(g);
		}
	}
}
