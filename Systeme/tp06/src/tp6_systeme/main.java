package tp6_systeme;

public class main {

	public static void main(String[] args) {
		final Semaphore s = new Semaphore(0);
		
		Thread t1 = new Thread(new Runnable() {
			
			public void run() {
				s.p();
				System.out.println("2e Thread");
				s.v();
			}
		});
		
		Thread t2 = new Thread(new Runnable() {
			
			public void run() {
				System.out.println("1er Thread");
				s.v();
			}
		});

		Thread t3 = new Thread(new Runnable() {
			
			public void run() {
				s.p();
				System.out.println("3e Thread");
			}
		});
		
		t1.start();
		t3.start();
		try {
			Thread.sleep(300);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		t2.start();
	}

}
