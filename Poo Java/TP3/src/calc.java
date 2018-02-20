
public class calc {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		Pile<Double> pileNB = new Pile<Double>();
		System.out.println("Entrez l'expression : ");
		String expression = System.console().readLine();
		Double n1;
		Double n2;
		
		for (String s:expression.split(" ")){
			//check if is number -> empile
			//if is operateur -> depile les nombre et calcule -> empile 
			//stack expression
			
			if(Double.valueOf(s)!= null){
				pileNB.empiler(Double.valueOf(s));
			}
			
		}
		
		/*for(int i =0; i< expression.length(); i++){
			char c = expression.charAt(i);
			
			if(c != ' '){
				if(c >= 0 || c <= 9){
					
				}
			}
		}*/
		
		
		System.out.println("Resultat : ");
	}

}
