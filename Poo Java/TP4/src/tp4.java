import geom2D.Point2D;

public class tp4 {
	
	public static void main (String[] args){
		/*Point2D p0 = null;
		System.out.println(p0);
		
		Point2D p1 = new Point2D();
		System.out.println(p1);
		System.out.println(p1.defini());
		
		Point2D p2 = new Point2D(3,4);
		System.out.println(p2);
		System.out.println(p2.defini());
		
		System.out.println(p2.equals(p1));
		p1 = p2;
		System.out.println(p2.equals(p1));*/
		
		Point2D p1 = new Point2D (3,4);
		Point2D p2 = p1;
		System.out.println(p2.equals(p1));
		System.out.println("avec == " + (p2 == p1));
		
		p2 = new Point2D(3,4);
		System.out.println(p2.equals(p1));
		System.out.println("avec == " + (p2 == p1));
	}
	
}
