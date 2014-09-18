#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>
#include <stdio.h>
#include <signal.h>


pid_t pidFils;  
void test();
main(){

  pidFils = fork();
  test();

}

void test() {
	static int j = 0;
  if (pidFils==0){
		//fils cree
  }
  else{
		j++;
    int i;
    //for (i=0;i<10;i++){
		  printf("je suis le fils%d\n",j);
		  //sleep(1);
    //}
		if (j == 10) {
			return;
		}
		pidFils = fork();
		test();
  }
}
