#include <stdio.h>
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/sem.h>
#include <string.h>
#include <stdlib.h>
#include <sys/shm.h>
#include <sys/ipc.h>
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
struct shmid_ds buf;

int main(int argc, char* argv[]) {
  struct mybuf *m;

  int id = shmget(KEY, sizeof(*m), IPC_CREAT | 0666);
  if (id == -1) {
    perror("Creation memoire paratagee\n");
    exit(0);
  }
  m = (struct mybuf*) shmat(id, NULL, 0);
  if (m < 0)
  {
    perror("SHMMAT error\n");
    exit(0);
  }

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

  while(1) {
    p(m->min, &op);

    int i = 0;
    while(m->etat[i] != PLEIN) {
      i++;
      i %= MAX;
    }

    m->etat[i] = OCC;
    printf("consommateur : %d (%d)\n", m->tab[i], i);
    m->etat[i] = LIBRE;

    v(m->max, &op);
  }
}