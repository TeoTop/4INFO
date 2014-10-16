#include <stdio.h>
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/sem.h>
#include <string.h>
#include <stdlib.h>
#include <sys/shm.h>
#define MAX 5
#define KEY 24101204
#define PLEIN 2
#define OCC 1
#define LIBRE 0
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


struct mybuf {
  int tab[MAX];
  int etat[MAX];
  int max;
  int min;
};
struct sembuf op;

int main(int argc, char* argv[]) {
  int array[10] = {4,8,7,1,6,2,5,9,10,3};
  struct mybuf *m;

  int id = shmget(KEY, sizeof(*m), IPC_CREAT | 0666);
  if (id == -1) {
    perror("Creation memoire paratagee\n");
    exit(0);
  }
  m = (struct mybuf*) shmat(id, NULL, 0);

  if (m->max == 0)
  {
    m->max = semget(IPC_PRIVATE, 1, 0666 | IPC_CREAT);
    if(m->max < 0) perror("Error: semget");
    initialisation(m->max, MAX);
  }
  if (m->min == 0)
  {
    m->min = semget(IPC_PRIVATE, 1, 0666 | IPC_CREAT);
    if(m->min < 0) perror("Error: semget");
    initialisation(m->min, 0);
  }

  int j = 0;
  while(1) {
    p(m->max, &op);

    int i = 0;
    while(m->etat[i] != LIBRE) {
      i++;
      i %= MAX;
    }

    m->etat[i] = OCC;
    m->tab[i] = array[j++ % 10];
    printf("producteur : %d (%d)\n", m->tab[i], i);
    m->etat[i] = PLEIN;
  
    v(m->min, &op);
  }

}