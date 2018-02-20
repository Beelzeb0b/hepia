
import java.util.Random; 
public class Tp1e {
	public static void main(String[] args){
		System.out.println("Donner moi le rayon de votre cercle");
		double r = Clavier.in.nextDouble();
		System.out.println("l'aire du cercle est de " + aire(r));
		
		int[][] A = new int[2][3];
		int[][] B = new int[3][2];
		randInit(A,0,10);
		randInit(B,0,10);
		println(A);
		println(B);
		println(mult(A,B));
	}
	
	public static double aire(double r){
		return Math.PI * r * r;
	}
	
	
	
	public static void randInit(int[][] M,int inf, int sup){
		Random alea = new Random();
		for(int i=0;i<M.length;i++){
			for (int j=0; j<M[i].length;j++){
				M[i][j] = inf + alea.nextInt(sup+inf);
			}
		}
	}
	
	public static void println(int[][] M){
		System.out.println();
		for(int i=0; i<M.length; i++){
			for(int j=0;j<M[i].length; j++){
				System.out.print(M[i][j]+ " ");
			}
			System.out.println();
		}
	}
	
	public static int[][] mult(int[][] A, int[][] B){
		int[][] C = new int[A.length][B[0].length];
		for (int i=0; i<A.length;i++) { // aRow
            for (int j=0;j<B[0].length; j++) { // bColumn
                for (int k=0; k<A[0].length; k++) { // aColumn
                    C[i][j] += A[i][k] * B[k][j];
                }
            }
        }
		return C;
	}

}

