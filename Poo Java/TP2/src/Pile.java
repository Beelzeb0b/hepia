import java.util.ArrayList;
import java.util.EmptyStackException;

class Pile<T> {

	private ArrayList<T> container ; 
	
	public Pile (){
		container = new ArrayList<T>();
	}
	
	public void empiler(T element) {
		container.add(element);
	}
	
	public Object depiler() {
		int size = container.size();
		Object objectToReturn = null; 
		// check if there one or more element in stack
		if (size >= 1)
		{
			objectToReturn = container.get(size - 1);
			container.remove(size - 1);
		}else{
			//throw new exeption
			throw new EmptyStackException();
		}
		
		return objectToReturn;
	}
	
	public void sommet(){
		
	}
	
	public void estVisible(){
		
	}
}



