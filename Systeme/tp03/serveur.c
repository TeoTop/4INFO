#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <signal.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>


struct sigaction action1;
struct sigaction action2;
sigset_t mask_nv;
sigset_t mask_anc;

void service(char* msg) {
	int fd;
	if ((fd = open("/tmp/montube", O_WRONLY)) == -1) {
		perror("open error");
		exit(1);
	}
	write(fd, msg, strlen(msg) + 1);
	close(fd);
}

void service1(){
	service("Service 1");
}

void service2(){
	service("Service 2");
}

int main (int argc, char * argv[])
{
	
	sigemptyset(&mask_nv);	//initialise un ensemble vide de signaux (mask_nv).
  sigaddset(&mask_nv, SIGUSR1);
	sigaddset(&mask_nv, SIGUSR2);
	sigprocmask(SIG_BLOCK, &mask_nv, &mask_anc);

  //Définition du handler
  action1.sa_handler=service1;
	action2.sa_handler=service2;
  sigaction(SIGUSR1,&action1,NULL);
	sigaction(SIGUSR2,&action2,NULL);


	while(1) {
		sigsuspend (&mask_anc);
	}

}


