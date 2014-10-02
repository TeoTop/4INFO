#include <stdlib.h>
#include <stdio.h>
#include <errno.h>
#include <signal.h>
#include <sys/types.h>


int main (int argc, char * argv[])
{
	int i,pid;
	for (i = 0; i < 10; ++i) {
	    pid = fork();
	    if (pid) {
	    	wait(pid);
	        continue;
	    } else if (pid == 0) {
	    	printf("%d\n", getppid());
	    	sleep(2);
	        break;
	    } else {
	        perror("fork error\n");
	        exit(1);
	    }
	}
	return 0;
}
