/*
 * Cedric Dos Reis
 * Java - TP5 : Grapheur
 * 19.11.2017
 * Package : geom2D
 */
package geom2D;

public class Droite2D {
	private Point2D point = null;
	private double pente = 1.0; // pente de la droite
	
	//CTOR
	// point et pente
	public Droite2D(Point2D p, double m){
		this.setPointPente(p, m);
	}
	// point et ordonné à l'origine
	public Droite2D(double m, double ord){
		this.pente = m;
		
	}
	// deux points
	public Droite2D(Point2D p1, Point2D p2){
		this.point = p1;
		// A voir si la fraction est une division par 0
		this.pente = (double) ((p2.getY() - p1.getY())) / (double) ((p2.getX() - p1.getX())); // (y2-y1)/(x2-x1)
	}
	
	// SET
	public void setPoint(Point2D p){
		this.point = p;
	}
	public void setPente(double p){
		this.pente = p;
	}
	public void setPointPente(Point2D p , double m){
		this.point = p;
		this.pente = m;
	}
	
	//GET
	public Point2D getPoint(){
		return this.point;
	}
	public double getPente(){
		return this.pente;
	}	
	
	// ordonnée d'intersection avec axe x
	public double getIntersectionX(){
		//à completer
		return 0.0;
	}
	// ordonnée d'intersection avec axe y
	public double getIntersectionY() {
		// à completer
		return 0.0;
	}
	
	//à completer
	public boolean contient(Point2D p){
		return false;
	}
	
	public boolean estParallele(Droite2D d){
		if(d.pente == this.pente)
			return true;
		else 
			return false;
		
	}
	
	// à completer
	public boolean equals(Object o){
		return false;
	}
	
	//à completer
	public String toString(){
		return "vide";
	}
	//à completer
	public StringBuilder toStrring2() {
		return new StringBuilder();
	}
	
}

