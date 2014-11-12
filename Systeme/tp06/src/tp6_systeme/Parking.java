package tp6_systeme;

public class Parking {
	private Semaphore voiture;
	private Semaphore entree;
	private Semaphore sortie;
	
	public Parking(int nbPlace) {
		voiture = new Semaphore(nbPlace);
		entree = new Semaphore(2);
		sortie = new Semaphore(1);
	}
	
	public void entrer(final String msg) {
		
		Thread t = new Thread(new  Runnable() {
			
			public void run() {
				try {//verification du gardien
					Thread.sleep(1000);
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
				entree.p();
				System.out.println("Attente : " + msg + " : " + voiture.getCounter());
				voiture.p();
				System.out.println(msg);
				//nvlle voiture
				entree.v();
			}
		});
		t.start();
	}
	
	public void sortir(String msg) {
		sortie.p();
		voiture.v();
		sortie.v();
		System.out.println(msg);
	}
}
