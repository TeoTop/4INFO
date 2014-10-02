#include <stdlib.h>
#include <stdio.h>
#include <errno.h>
#include <signal.h>
#include <sys/types.h>
#include <sys/prctl.h>


int recu = 0;
int flag = 0;
struct sigaction action1;
struct sigaction action2;
sigset_t mask_nv;
sigset_t mask_anc;

void handler1(int sig){
  printf("recu %d\n", ++recu);
}
void handler2(int sig){

}

/*void handler2(int sig){
  
}*/


int main (int argc, char * argv[])
{
  // bloque SIGUSR1
  sigemptyset(&mask_nv);	//initialise un ensemble vide de signaux (mask_nv).
  sigaddset(&mask_nv, SIGUSR1); // A decommenter  // ajoute le signal SIGUSR1 à l'ensemble mask_nv
  sigaddset(&mask_nv, SIGUSR2); // A decommenter  // ajoute le signal SIGUSR1 à l'ensemble mask_nv
  //Définition du handler
  sigprocmask(SIG_BLOCK, &mask_nv, &mask_anc);

  action1.sa_handler=handler1;
  action2.sa_handler=handler2;
  sigaction(SIGUSR1,&action1,NULL); // lie l'action au signal
  sigaction(SIGUSR2,&action2,NULL); // lie l'action au signal

//creation d'un processus
  int pid=fork();
	
  if(pid==-1)
    {
      perror("Creation du processus fils echoue");
      exit(0);
    }

  //fils
  if(pid==0)
    {
      prctl(PR_SET_PDEATHSIG, SIGHUP);// fils meurt qd le père a fini d'envoyer les signaux
      while(1) {
        sigsuspend(&mask_anc); 
        int pid_papa = getppid();
        kill(pid_papa,SIGUSR2);
      }
    }
  else //pere
    {
			int i;
			for (i = 1; i <= 5000; i++)
      {
        printf("envoi %d\n", i);
        kill(pid, SIGUSR1);
        sigsuspend(&mask_anc); 
			}
    }	
}
