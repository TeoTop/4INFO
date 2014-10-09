#include <stdio.h>
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/sem.h>
#include <string.h>
#include <stdlib.h>

#define KEY 24101204

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
  int tab[10];
  int fus[10];
  int tab1[10];
  int tab2[10];
  int n1;
  int n2;
  int lg;
};
struct sembuf op;
void creer2fils(struct mybuf *m) {
  
  int mutex1 = semget(IPC_PRIVATE, 1, 0666 | IPC_CREAT);
  if(mutex1 < 0) perror("Error: semget");
  initialisation(mutex1, 0);
  
  int mutex2 = semget(IPC_PRIVATE, 1, 0666 | IPC_CREAT);
  if(mutex2 < 0) perror("Error: semget");
  initialisation(mutex2, 0);
  
  int sem = semget(IPC_PRIVATE, 1, 0666 | IPC_CREAT);
  if(sem < 0) perror("Error: semget");
  initialisation(sem, 0);
  
  m->n1 = (int) m->n1 / 2;
  m->n2 = m->n2 / 2 - m->n1;
  int i;
  for (i = 0; i < m->n1; ++i)
  {
    m->tab1[i] = m->tab[i];
  }
  for (i = 0; i < m->n2; ++i)
  {
    m->tab2[i] = m->tab[m->n1 + i];
  }
  
  int pid1 = fork();
  if (pid1 == 0) {//fils
    p(sem, &op);
    printf("\tfils1 %d mon pere est %d\n",getpid(),getppid());
    if (m->n1 > 1) 
    {
      creer2fils(m);
    }
    v(mutex1, &op);
  }
  else {//père
    int pid2 = fork();
    if (pid2 == 0) {//fils
      p(sem, &op);
      printf("\tfils2 %d mon pere est %d\n",getpid(),getppid());
      if (m->n2 > 1) 
      {
        creer2fils(m);
      }
      v(mutex2, &op);
    }
    else {
      printf("pere %d\n",getpid());
      v(sem, &op);
      v(sem, &op);
      p(mutex1, &op);
      p(mutex2, &op);
      suppression(mutex2);
      suppression(mutex1);
      int i,j,k;
      for (k = 0,i = 0,j = 0; k < m->n1 + m->n2; k++)
      {
        if (i == m->n1)
        {
          m->fus[k] = m->tab2[j++];
        }
        if (j == m->n2) {
          m->fus[k] = m->tab1[i++];
        }
        if (m->tab1[i] < m->tab2[j])
        {
          m->fus[k] = m->tab1[i++];
        }
        else {
          m->fus[k] = m->tab2[j++];
        }
      }
    }
  }
}

int main(int argc, char* argv[]) {
  int array[10] = {4,8,7,1,6,2,5,9,10,3};
  struct mybuf *m;
  int id = shmget(KEY, sizeof(*m), IPC_CREAT | 0666);
  if (id == -1) {
    perror("Creation memoire paratagee\n");
    exit(0);
  }
  //m = (struct mybuf*) shmat(id, NULL, 0);
  m = (struct mybuf*) malloc(sizeof(struct mybuf));
  int i;
  for (i = 0; i < 10; ++i)
  {
    m->tab[i] = array[i];
  }
  m->lg = 10;
  m->n1 = 10;
  m->n2 = 10;

  int pid = getpid();

  creer2fils(m);

  if (pid == getpid())
  {
    for (i = 0; i < 10; ++i)
    {
      printf("%d\n", m->fus[i]);
    }
  }
  return 0;
}
