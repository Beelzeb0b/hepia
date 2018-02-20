/*
 * Cedric Dos Reis
 * Java - TP5 : Grapheur
 * 19.11.2017
 */
import java.awt.*;
import java.awt.event.*;
import java.io.*;
import java.util.*;
import javax.swing.*;
import geom2D.*;


public class Grapheur {
	
   
	// MAIN
    public static void main(String[] args) {	
    	DataPoints listePts = new DataPoints("fichierPoints.txt");
    	int width = 400;
    	int height = 400;
    	DessinPoints monGraphe = new DessinPoints(listePts,width,height,10,10);
    	
    	// Fenetre
    	JFrame frame = new JFrame();
    	frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    	frame.add(monGraphe,"Center");
    	frame.setTitle("Grapheur");
    	frame.setSize(width, height);
        frame.setVisible(true);
    }
}


class DataPoints extends ArrayList<ArrayList<Point2D>> {   
	double min_x, min_y, max_x, max_y;
	
	public double getMinX() {
		return min_x;
	}
	public double getMaxX() {
		return max_x;
	}
	public double getMinY() {
		return min_y;
	}
	public double getMaxY() {
		return max_y;
	}
	
	//ArrayList<ArrayList<Point2D>> points = new ArrayList<ArrayList<Point2D>>();
    
    DataPoints(String fichier) {
		LineNumberReader lecteurLignes = null;		
		try {
		    lecteurLignes = new LineNumberReader(new FileReader(fichier));
		    String ligneTexte = null;
		    
		    while ((ligneTexte = lecteurLignes.readLine()) != null) {
		    	StringTokenizer st = new StringTokenizer(ligneTexte);
		    	// stocker les points dans le vecteur courant	
		    	if (st.countTokens() == 2) {
		    		// crée un point avec les valeur du StringTokenizer
		    		Point2D point = new Point2D(Integer.parseInt(st.nextToken()), Integer.parseInt(st.nextToken()));
		    		// Mets le point dans une liste temporaire 
		    		ArrayList<Point2D> temp = new ArrayList<Point2D>();
		    		temp.add(point);
		    		// Mets la liste temp dans la liste finale
		    		this.add(temp);
		    	}
		    	else  if (st.countTokens() == 4) { 
		    		
		    		Point2D point1 = new Point2D(Integer.parseInt(st.nextToken()), Integer.parseInt(st.nextToken()));
		    		Point2D point2 = new Point2D(Integer.parseInt(st.nextToken()), Integer.parseInt(st.nextToken()));
		    		ArrayList<Point2D> temp = new ArrayList<Point2D>();
		    		temp.add(point1);
		    		temp.add(point2);
		    		this.add(temp);
		    	}
		    	else {
		    		//erreur de données
		    		JOptionPane.showMessageDialog(null,
		    			    "Erreur sur le nombre de données.",
		    			    "Grapheur erreur",
		    			    JOptionPane.ERROR_MESSAGE);
		    	}
	  				
		    }			
		}
		catch(Exception e) { e.printStackTrace(); }		
		min_max();
		
		/*System.out.println(this);
		System.out.println("min x " + min_x);
		System.out.println("min y " + min_y);
		System.out.println("max x " + max_x);
		System.out.println("max y " + max_y);*/
    }
    
    private void min_max() {
    	// trouver les coordonnées extrêmes {min_x}, {max_x}, {min_y},
    	// {max_y} des points stockés dans le vecteur courant
    	
    	max_x = this.get(0).get(0).getX();
    	min_x = max_x;
    	max_y = this.get(0).get(0).getY();
    	min_y = max_y;
    	
    	for(int i = 0; i < this.size() ; i++ ){
    		for (int j = 0; j < this.get(i).size(); j++ ){
    			Point2D point = this.get(i).get(j);
    			if(point.getX() < min_x){
    				min_x = point.getX(); 
    			}else if(point.getX() > max_x){
    				max_x = point.getX();
    			}
    			
    			if(point.getY() < min_y){
    				min_y = point.getY(); 
    			}else if(point.getY() > max_y){
    				max_y = point.getY();
    			}
    		}
    	}
    	// marge pour l'affiche 
    	min_x -= 10;
    	max_x += 10;
    	min_y -= 10;
    	max_y += 10;
    }	
}

// DESSIN POINTS
class DessinPoints extends JPanel {
    DataPoints listePts;
    int bord;          // taille des bords
    int enveloppe;     // dimension des rectangles
    private JPanel panel;
    // CTOR
    DessinPoints(DataPoints pts, int largeur, int hauteur, int bord, int enveloppe) {		
    	// Constructeur: 
    	// {largeur} et {hauteur} permettent de fixer la taille du JPanel
    	// avec la méthode {setPreferredSize()}
    	listePts = pts;
    	this.bord = bord;
    	this.enveloppe = enveloppe;
    	
    	
    }
    
    
    
    public void paintComponent(Graphics g) {
    	super.paintComponent(g);
    	g.setXORMode(Color.red);
    	// lire les points de {listePts} et dessiner les rectangles et les droites correspondants	
    	
    	//DESSINER LES POINTs ET LES DROITEs
    	
    	// etendue de  largeur et hauteur 
    	double etendueX = listePts.getMaxX()  - listePts.getMinX() ;
    	double etendueY = listePts.getMaxY() - listePts.getMinY() ;
    	
    	double echelleX = this.getSize().width / (etendueX +5);
    	double echelleY = this.getSize().height / (etendueY + 5);
    	
    	// dessine les points et les lignes
    	for (int i = 0; i< listePts.size(); i++){
    		int size = listePts.get(i).size(); 
    		//System.out.println("size de " + String.valueOf(i) + " = " + size);
    		switch (size){ // dessine un point
    		case 1:
    			int x = (int) (listePts.get(i).get(0).getX() * echelleX) ;
    			int y = (int) (listePts.get(i).get(0).getY() * echelleY) ;
    			g.drawRect(x , y , enveloppe, enveloppe);
    			break;
    			
    		case 2: // dessine une ligne et ses points
    			// y = a*x+b : équation d'une droite
    			// a = pente, b = ordonnée à l'origine quand x=0
    			
    			int x1 = listePts.get(i).get(0).getX();
    			int y1 = listePts.get(i).get(0).getY();
    			int x2 = listePts.get(i).get(1).getX();
    			int y2 = listePts.get(i).get(1).getY();
    			
    			//dessine les rectangles 
    			int x1_ech = (int) (x1 * echelleX);
    			int y1_ech = (int) (y1 * echelleY);
    			int x2_ech = (int) (x2 * echelleX);
    			int y2_ech = (int) (y2 * echelleY);
    			g.drawRect(x1_ech, y1_ech, enveloppe, enveloppe);
    			g.drawRect(x2_ech, y2_ech, enveloppe, enveloppe);
    			
    			// crée l'objet droite
    			Droite2D droite = new Droite2D(listePts.get(i).get(0), listePts.get(i).get(1));
    			
    			//calcul l'orddonné à l'origine : -b = a*x-y 
    			int oo = (int) ((droite.getPente() * x1 - y1) * -1);
    			int oo_ech = (int) (oo * echelleY);
    			
    			//calcul un point hors fenetre
    			int x3 = (int) ((this.getSize().width + 50) / echelleX);
    			int y3 = (int) (droite.getPente() * x3 + oo);
    			
    			int x3_ech = (int) (x3 * echelleX);
    			int y3_ech = (int) (y3 * echelleY);
    			
    			//dessine la ligne
    			g.drawLine(0, oo_ech, x3_ech, y3_ech);
    			break;
    			
    			// les erreurs de precision sont causées par le transtypage de valeurs double en integer
    			
    		}
    	}
    	//g.drawString("Les erreurs de precision sont causées par le transtypage de valeurs double en integer", 10, 10);
    		
    }
}


