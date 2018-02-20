/*
 * Cedric Dos Reis 
 * 14.01.2018
 * POO Java - Plants vs Zombies
 */
import java.awt.Graphics;
import java.awt.Point;
import java.util.ArrayList;

import javax.swing.ImageIcon;
import javax.swing.JPanel;
import javax.xml.stream.events.EndElement;

public class Game extends Thread {
	public Window window;	
	private static int width = 1200;
	private static int height = 750;
	private int suns = 0;
	boolean GameOver = false;
	private ArrayList<Entity> elements; // all objects in game
	private ArrayList<Entity> elementsToAdd;
	private ArrayList<Entity> elementsToRemove;
	private Graphics panelGraphics; // graphics where everything is draw
	private Grid grid;
	private long elapsedTime;
	public PlantType selectedPlant;
	private ZombieGenerator zGenerator;
	//private Drawer drawer;
	
	public Game() {
		super("GameThread");
		window = new Window(width, height, this);
		elements = new ArrayList<Entity>();
		elementsToAdd = new ArrayList<Entity>();
		elementsToRemove = new ArrayList<Entity>();
		
		  
		grid = new Grid(5, 5, new Point(220, 80), new Point(846, 615));
		elapsedTime = 0;
		suns = 900000000;
		zGenerator = new ZombieGenerator(this);
		panelGraphics = window.getPanelGraphics();
		//drawer = new Drawer(this, panelGraphics, width, height);
	}
	
	// Update 
	@Override
	public void run() {
		while(!GameOver) {
			elapsedTime = System.nanoTime();
			//System.out.println("Timeelapsed " + elapsedTime);
			//paint background
			panelGraphics.clearRect(0, 0, width, height); // clear panel
			window.paintComponents(panelGraphics); // draw Background

			// insetrt new elemets in list 
			for (Entity e : elementsToAdd) {
				elements.add(e);
			}
			elementsToAdd.clear();
			
			//removes elements
			for (Entity e : elementsToRemove) {
				elements.remove(e);
			}
			elementsToRemove.clear();
			
			// Update and Draw all elements (plants, zombiess and projectiles)
			for (Entity e : elements) {
				if (e.getLocation().x > 0 && e.getLocation().x < width) {
					e.Update(System.nanoTime() - elapsedTime);
					e.paintComponent(panelGraphics);
				}else {
					elementsToRemove.add(e);
				}
				
			}
			
			try {
				sleep(100);
			} catch (InterruptedException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		}
	}
	// retourne le contenu de la list des éléments
	public ArrayList<Entity> GetElements(){
		return elements;
	}
	
	
	public void NewPlant(PlantType _type, Point _location) {
		Box box = grid.getNearestBox(_location);
		
		// use the shovel to unearth the plant from the box
		if (_type == PlantType.Shovel && !box.isEmpty()) {
			elementsToRemove.add(box.plant);
			box.RemovePlant();
		}else {
			if(box.isEmpty()) {
				switch(_type) {
					case Pea :
						if(suns >= 100) {
							elementsToAdd.add(new Pea(new Point(box.center), new ImageIcon("images/Pea.gif").getImage()));
							suns -= 100;
						}			
						break;
					case SnowPea :
						if(suns >= 175) {
							suns -= 175;
						}
						//elementsToAdd.add(n)
						break;
					case Nut :
						if(suns >= 50) {
							elementsToAdd.add(new Plant(box.center, new ImageIcon("images/nut.gif").getImage()));
							suns -= 50;
						}
						break;
					case Sun :
						if(suns >= 50) {
							suns -= 50;
						}
						
					default :
					break;
				}
			}
		}
		if(zGenerator.getState() == State.NEW) {
			zGenerator.start();
		}
	}
	
	
	public void NewZombie(Zombie z) {
		elementsToAdd.add(z);
	}
}
