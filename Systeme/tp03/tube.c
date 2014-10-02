#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>


int main (int argc, char * argv[])
{
  char* nom = argv[argc-1];
  printf("Argument : %s\n", nom);
  int tp[2];
  pipe(tp);
  int test = fork();
  char lecture[100];


  if(test == 0){
    close(tp[0]);
    dup2(tp[1], STDOUT_FILENO);
    close(tp[1]);
    execl("/bin/who","who", 0);
  } else {
    close(tp[1]);
    dup2(tp[0], STDIN_FILENO);
    close(tp[0]);
    execl("/bin/grep","grep", nom, 0);
    //printf("%s", lecture);
  }

  return 0;
}

