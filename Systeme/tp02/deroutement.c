#include <stdlib.h>
#include <stdio.h>
#include <errno.h>
#include <signal.h>
#include <sys/types.h>
#include <setjmp.h>


int i = 0;
int j = 0;
jmp_buf env;
struct sigaction action;

void handler(int sig){

  printf("div 0\n");
  i=1;
  j=1;
//   longjmp(env,0);  // A decommenter
}

int main (int argc, char * argv[])
{
  
  

  //D�finition du handler
  action.sa_handler=handler;
  signal(SIGFPE,(*handler));
  // setjmp(env);    // A decommenter
  printf("deb i=%d j=%d\n", i ,j);
  j = 12/i;
  printf("fin i=%d j=%d\n", i, j);
  exit(0);
}

/*Le programme boulce sur la ligne de la division par zero. En effet, lors du premi�re appel � cette ligne, l'affectation de la division par zero, par cons�quent, le signal SIGFPE se d�clenche et le handler est appel�. Sauf que la division est d�ja effectuer, donc modifier ne sert � rien. En revanche, l'affectation va elle continuer � tenter d'obtenir une valeur correct. Cela va provoquer une boucle. Pour r�gler le probl�me, il faut cr�er un goto sur une ligne ant�rieur afin de refaire la division puis l'affectation avec les nouvelles valeurs pour i et j.

*/  
