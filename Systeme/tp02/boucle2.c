#include <stdlib.h>
#include <stdio.h>
#include <errno.h>
#include <signal.h>
#include <sys/types.h>

struct sigaction action;
sigset_t mask_nv;
sigset_t mask_anc;

void handler(int sig){
  if(sig == SIGUSR1){
    printf("A toi mon fils !!!\n");
  } else if(sig == SIGUSR2){
    printf("A toi mon père !!!\n");
  } else {
    printf("Erreur !!!\n");
  }
  
}

int main (int argc, char * argv[])
{
  // bloque SIGUSR1
  sigemptyset(&mask_nv);	//initialise un ensemble vide de signaux (mask_nv).
  sigaddset(&mask_nv, SIGUSR1); // A decommenter  // ajoute le signal SIGUSR1 à l'ensemble mask_nv
 // sigaddset(&mask_nv, SIGUSR2); // A decommenter  // ajoute le signal SIGUSR1 à l'ensemble mask_nv
  sigprocmask(SIG_BLOCK, &mask_nv, &mask_anc); //bloque les signaux du mask courant (mask_nv) et définie un masque ancien (mask_anc)

  //Définition du handler
  action.sa_handler=handler;
  sigaction(SIGUSR1,&action,NULL); // lie l'action au signal
  //sigaction(SIGUSR2,&action,NULL); // lie l'action au signal

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
      sigsuspend (&mask_anc);
      int i;
			for(i=0 ; i<10 ; i++){
        printf("b\n");
      }
      //kill(getppid(),SIGUSR2);
    }
  else //pere
    {
	    int i;
      for(i=0 ; i<10 ; i++){
        printf("a\n");
      }

      kill(pid,SIGUSR1);
      //sigsuspend (&mask_anc);
      wait(NULL);//Attente de la fin de tous les fils
       printf("J'ai fini\n");
    }	
}
