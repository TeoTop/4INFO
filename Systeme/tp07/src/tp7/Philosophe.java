package tp7;

public class Philosophe extends Thread {
	int _id;
	Table _table;
	
	Philosophe (int i, Table t) {
		_id = i;
		_table = t;
	}
	
	public void run() {
		try {
			while(true) {
				System.out.println("Je desire manger "+_id);
				_table.prendreBaguettes(_id);
				System.out.println("J'ai fini de manger "+_id);
				System.out.println("Je pense "+_id);
				sleep(5000);
			}
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
	}
}
