// Read sentences from the console
// stop when command stop is wrote
public class Tp1d {
	public static void main(String[] args){
		String sentence = "";
		System.out.println("PC: So what do you have to say ?");
		sentence = Clavier.in.next(); // read the string
		
		while (!sentence.equals("stop")) // tant que la phrase n'est pas "stop"
		{
			System.out.println("You: "+sentence); // display user sentence
			System.out.println("PC: What's next ?");
			sentence = Clavier.in.next(); // read sentence
		}
		System.out.println("Auf Wiedersehen !");
		
		/* version prof
		while(true){
			String phrase = Clavier.in.next();
			Sytem.out.println(phrase);
			if(phase==null || phrase.equals("quit")) break;
		
			
		*/
	}
	
	
	
}
