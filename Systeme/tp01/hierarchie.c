#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>
#include <stdio.h>
#include <signal.h>


pid_t pidFils;  
void test();
main(){
	int i;
	//pidFils = fork();
	pid_t ancetre[4] = {getpid(),0};
	test(0, ancetre);

}

void test(int j, pid_t* ancetre) {

  if (pidFils!=0){
		//pere
		//wait(pidFils);
  }
  else{
	//fils
    int i;
		int k;
		if (j > 3) {
			return;
		}
		printf("%d- je suis le processus %d\n",j,getpid());
		for (k=0;k<j;k++) {
			printf("	mon pere est %d\n",ancetre[k]);
		}
		ancetre[j] = getpid();
		for (i = 0;i < 2;i++) {
			pidFils = fork();
			if (pidFils == 0) {
				test(j+1, ancetre);
				break;
			}
			else {
				wait(pidFils);
			}
		}
  }
}
