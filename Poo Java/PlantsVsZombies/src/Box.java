/*
 * Cedric Dos Reis 
 * 14.01.2018
 * POO Java - Plants vs Zombies
 */
import java.awt.Point;

public class Box {
	int line; // line position in the grid
	int col; // colunm position in the grid
	Plant plant; // plant this case
	Point center; // location in the jpanel
	
	public Box(int _col, int _line, Point _center) {
		this.line = _line;
		this.col = _col;
		this.center = _center;
	}
	
	public void InsertPlant(Plant _plant) {
		this.plant = _plant;
		this.plant.PutInBox(this);
	}
	
	public void RemovePlant() {
		this.plant = null;
	}
	
	public boolean isEmpty() {
		if (plant == null) {
			return true;
		}else {
			return false;
		}
	}
}
