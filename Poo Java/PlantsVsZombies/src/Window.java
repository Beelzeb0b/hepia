/*
 * Cedric Dos Reis 
 * 14.01.2018
 * POO Java - Plants vs Zombies
 */
import java.awt.Container;
import java.awt.Graphics;
import java.awt.GridLayout;
import java.awt.Insets;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseListener;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JSplitPane;

public class Window extends JFrame implements ActionListener{
	private GameUI gameUI;
	private Game game;
	JButton btnPea;
	JButton btnSnowPea;
	JButton btnPotato;
	JButton btnSunFlower;
	JButton btnShovel;
	public Window (int width , int height, Game _game) {
		super();
		this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		this.setLocationRelativeTo(null);
		this.setTitle("Plants vs Zombie - Cedric Dos Reis");
		this.setResizable(false);
		this.setSize(width, height);
		//this.getContentPanel().setLayout(null);
		
		this.game = _game;
		
		// create playground interface
		gameUI = new GameUI(game);
		gameUI.setSize(width, height/7*6);
		gameUI.setLayout(null);
		this.add(gameUI);
		gameUI.setLocation(0, 0);
		gameUI.repaint();
		
		// panel for the buttons
		JPanel pnlButton = new JPanel();
		pnlButton.setSize(width, height/7);
		pnlButton.setLayout(null);
		pnlButton.setLocation(0, height/7*6);
		
		// crete buttons
		btnPea = new JButton("Pea");
		btnPea.addActionListener(this);
		pnlButton.add(btnPea);
		btnSnowPea = new JButton("SnowPea");
		btnSnowPea.addActionListener(this);
		pnlButton.add(btnSnowPea);
		btnPotato = new JButton("Potato");
		btnPotato.addActionListener(this);
		pnlButton.add(btnPotato);
		btnSunFlower = new JButton("SunFlower");
		btnSunFlower.addActionListener(this);
		pnlButton.add(btnSunFlower);
		btnShovel = new JButton("Shovel");
		btnShovel.addActionListener(this);
		pnlButton.add(btnShovel);
		
		this.add(pnlButton);
				
		this.setVisible(true);
	}
	public Graphics getPanelGraphics() {
		return this.gameUI.getGraphics();
	}
	
	@Override
	public void paintComponents(Graphics g) {
		gameUI.paintComponent(getPanelGraphics());
		//super.paintComponents(g);
	}
	
	@Override
	public void actionPerformed(ActionEvent e) {
		if (e.getSource() == btnPea) {
			game.selectedPlant = PlantType.Pea;
		}else if (e.getSource() == btnSnowPea) {
			game.selectedPlant = PlantType.SnowPea;
		}else if (e.getSource() == btnPotato) {
			game.selectedPlant = PlantType.Nut;
		}else if (e.getSource() == btnSunFlower) {
			game.selectedPlant = PlantType.Sun;
		}else if (e.getSource() == btnShovel) {
			game.selectedPlant = PlantType.Shovel;
		}
	}
}
