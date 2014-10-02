#include <stdlib.h>
#include <stdio.h>
#include <errno.h>
#include <signal.h>
#include <sys/types.h>


struct sigaction action;
sigset_t mask_nv;
sigset_t mask_anc;

void handler(int sig){
  printf("Signal recu\n");
}

int main (int argc, char * argv[])
{
  
  // bloque SIGUSR1
  sigemptyset(&mask_nv);	//initialise un ensemble vide de signaux (mask_nv).
  sigaddset(&mask_nv, SIGUSR1); // A decommenter  // ajoute le signal SIGUSR1 à l'ensemble mask_nv
  sigprocmask(SIG_BLOCK, &mask_nv, &mask_anc); //bloque les signaux du mask courant (mask_nv) et définie un masque ancien (mask_anc)

  //Définition du handler
  action.sa_handler=handler;
  sigaction(SIGUSR1,&action,NULL); // lie l'action au signal

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
      sleep(1);
      printf("Debut attente du fils\n");
      sigsuspend (&mask_anc);		//permet d'endormir le processus et de revenir à l'ancien mask
      printf("Fin attente du fils\n");
      exit(0);
    }
  else //pere
    {
      kill(pid,SIGUSR1); //On envoie le signal SIGUSR1 au processus fils dont le pid est pid
      //On a redéfini le comportement du handler de SIGUSR1
      printf("Debut attente du pere\n");
      wait(NULL);//Attente de la fin de tous les fils
      printf("Fin attente du pere\n");
	
    }	
  exit(0);
}


/* si sigaddset(&mask_nv, SIGUSR1); n'est pas définie, le signal ne fait pas partie des signaux bloqués donc celui-ci s'execute dès lors que le père fait appel à celui-ci donc avant que le fils ne soit en attente.
*/ 
