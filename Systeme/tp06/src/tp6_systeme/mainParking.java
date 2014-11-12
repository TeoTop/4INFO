package tp6_systeme;

public class mainParking {

	public static void main(String[] args) {
		final Parking p = new Parking(3);
		p.entrer("Entree 1");

		p.entrer("Entree 2");
		
		p.entrer("Entree 3");
		
		p.entrer("Entree 4");

		p.entrer("Entree 5");

		p.entrer("Entree 6");
		
		try {
			Thread.sleep(2000);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		p.sortir("Sortie 1");
	}

}
