/*
 * Cedric Dos Reis 
 * 14.01.2018
 * POO Java - Plants vs Zombies
 */
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseListener;

import javax.swing.*;

import org.w3c.dom.events.EventTarget;
import org.w3c.dom.events.MouseEvent;
import org.w3c.dom.views.AbstractView;

public class GameUI extends JPanel implements MouseListener{
	private Image img;
	Game game;
		
	public GameUI(Game _game) {
		super();
		//this.setBackground(Color.red);
		img = new ImageIcon("images/Background1.jpg").getImage(); // set image
		addMouseListener(this); // ecoute les evenement de la souris
		game = _game;
	}
	
	public void paintComponent(Graphics g) {
		g.drawImage(img, 0, 0, getWidth(), getHeight(), this);
	}
	
	@Override
	public void mouseClicked(java.awt.event.MouseEvent e) {
		// TODO Auto-generated method stub
		System.out.println(" x : " + e.getX() + "    y : " + e.getY());
		game.NewPlant(PlantType.Pea, e.getPoint());
	}

	@Override public void mouseEntered(java.awt.event.MouseEvent e) { }
	@Override public void mouseExited(java.awt.event.MouseEvent e) { }
	@Override public void mousePressed(java.awt.event.MouseEvent e) { }
	@Override public void mouseReleased(java.awt.event.MouseEvent e) { }
}
