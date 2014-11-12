package tp6_systeme;

import java.util.LinkedList;
import java.util.Queue;

public class Semaphore {
	private int counter;
	private Queue<Object> queue;
	
	public int getCounter() {
		return counter;
	}

	public Semaphore(int counter) {
		this.counter = counter;
		this.queue = new LinkedList<Object>();
	}

	public void p(){
		Object o = new Object();
		boolean test = false;
		synchronized (o) {
			synchronized(this) {
				if(counter == 0){
					this.queue.add(o);
					test = true;
				} else {
					counter--;
				}
			}
			if(test) {
				try {
					o.wait();
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
			}
		}
	}
	

	public synchronized void v(){
		if (this.queue.size() > 0) {
			Object o = this.queue.remove();
			synchronized (o) {
				counter++;
				if (counter >= 0) {
					o.notify();
				}
			}
		} else {
			counter++;
		}
	}
}
