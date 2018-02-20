/*
 * Cedric Dos Reis 
 * 14.01.2018
 * POO Java - Plants vs Zombies
 */
import java.awt.Point;
import java.util.ArrayList;

public class Grid {
	private Box[][] Boxes;
	private int lines;
	private int cols;
	private Point startLocation;
	private Point endLocation;
	private int verticalStep;
	private int horizontalStep;
	
	public Grid(int _cols, int _lines, Point _startLocation, Point _endLocation) {
		lines = _lines;
		cols = _cols;
		Boxes = new Box[cols][lines]; // array 2d of cases
		startLocation = _startLocation; // location for the coordinates (0,0) of the grid
		endLocation = _endLocation; // location for the end of the grid
		verticalStep =  (endLocation.x - startLocation.x) / cols; // width of a case
		horizontalStep = (endLocation.y - startLocation.y) / lines; // height of a case
		for (int i = 0; i < cols; i++) {
			for(int j = 0; j < lines; j++) {
				Point boxCenter = 	new Point(startLocation.x + verticalStep/2 + verticalStep *i, startLocation.y + horizontalStep/2 + horizontalStep * j);
				Boxes[i][j]= new Box(i, j, boxCenter);
			}
		}
	}
	
	public Box getBox(int _col, int _line) {
		return Boxes[_col][_line];
	}
	
	public Box getNearestBox(Point _location) {
		int nbCol = Math.abs((startLocation.x - _location.x) / horizontalStep);
		int nbLine = Math.abs((startLocation.y - _location.y) / verticalStep); 		
		return getBox(nbCol,nbLine); 
	}
}
