#include <stdio.h>
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/sem.h>
#include <string.h>
#include <stdlib.h>

union semun
{
  int val;
  struct semid_ds *buf;
  ushort *array;
} arg;

int initialisation(int mysem, int init){
  arg.val = init;  // Valeur d'initialisation
  return semctl(mysem, 0, SETVAL, arg);
}

int p(int mysem, struct sembuf *op){
  op->sem_num = 0;
  op->sem_op = -1; //1=V, -1=P
  op->sem_flg = 0;

  return semop(mysem, op, 1);
}

int v(int mysem, struct sembuf *op){
  op->sem_num = 0;
  op->sem_op = 1; //1=V, -1=P
  op->sem_flg = 0;

  return semop(mysem, op, 1);
}

int suppression(int mysem) {
    return semctl(mysem, 0, IPC_RMID, arg);
}

int main(int argc, char* argv[]) {
  if (argc != 3)
  {
    perror("Usage: ./pub msg mutex");
    exit(1);
  }
  char* message;
  message = (char*) malloc(sizeof(char)*(strlen(argv[1]) + 1));
  strcpy(message,argv[1]);
  int mutex;
  if (strcmp(argv[2],"0") == 0)
  {
    mutex = semget(IPC_PRIVATE, 1, 0666 | IPC_CREAT);
    if(mutex < 0) perror("Error: semget");
  }
  else {
    mutex = atoi(argv[2]);
  }
  printf("Pub : %d\n", mutex);

  int retval = initialisation(mutex, 1);
  if(retval < 0) perror("Error: semctl");

  struct sembuf op;
  while(1) {
    retval = p(mutex, &op);
    if(retval != 0) perror("error: semop");
    sleep(2);
    printf("%s\n", message);
    printf("%s\n", message);
    v(mutex, &op); 
  }
  return 0;
}
