#include <stdio.h>
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/sem.h>

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

int main() {
  int mysem = semget(IPC_PRIVATE, 1, 0666 | IPC_CREAT);
  if(mysem < 0) perror("Error: semget");

  int retval = initialisation(mysem, 0);
  if(retval < 0) perror("Error: semctl");

  struct sembuf op;

  if (!fork()) {
    printf("block\n");
    retval = p(mysem, &op);
    if(retval != 0) perror("error: semop");
    retval = suppression(mysem);
    if(retval < 0) perror("Error: semctl");
  } else {
    sleep(2);
    printf("débloque\n");
    retval = v(mysem, &op);
    if(retval != 0) perror("error: semop");
  }    
  return 0;
}
