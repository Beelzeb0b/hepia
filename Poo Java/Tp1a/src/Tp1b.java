//TP1c.java
// Dos Reis Cedric - POO java - 09.2017
// Element in "args" are set in Run/Run Configurations/Arguments
public class Tp1b {
	public static void main(String[] args){
		System.out.println("Hello world !");
		System.out.println("Mon nom est: ");
		for (int i=0; i<args.length; i++){
			System.out.print(args[i]+ " ");
		}
	}
}