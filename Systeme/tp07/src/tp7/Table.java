package tp7;

import java.util.ArrayList;
import java.util.List;

public class Table {
	int _taille;
	Object _baguettes[];
	List<Integer> philosophe;
	
	Table(int t) {
		_taille = t;
		_baguettes = new Object[_taille];
		for (int i = 0; i < _taille; i++) {
			_baguettes[i]= new Object();
		}
		philosophe = new ArrayList<Integer>();
	}
	
	void prendreBaguettes(int i) throws InterruptedException {
		if (i % 2 == 0) {
			synchronized (_baguettes[i % _taille]) {
			    System.out.println(i + ": J'ai une baguette "+ (i % _taille));
			    Thread.sleep(100);
				synchronized (_baguettes[(i + 1) % _taille]) {
				    System.out.println(i + ": J'ai une baguette " + (i+1)%_taille);
				    Thread.sleep(100);
				    System.out.println("Je mange "+i);
				    Thread.sleep(5000);
				}
			}
		} else {
			synchronized (_baguettes[(i + 1) % _taille]) {
			    System.out.println(i + ": J'ai une baguette "+ (i % _taille));
			    Thread.sleep(100);
				synchronized (_baguettes[i % _taille]) {
				    System.out.println(i + ": J'ai une baguette " + (i+1)%_taille);
				    Thread.sleep(100);
				    System.out.println("Je mange "+i);
				    Thread.sleep(5000);
				}
			}
		}


	}
	
}

