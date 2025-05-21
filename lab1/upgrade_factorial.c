#include <fcntl.h>
#include <semaphore.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <sys/wait.h>
#include <unistd.h>

#include "factorial.h"

#define SEMA_NAME "/factorial_sema"
#define SHMEM_NAME "/factorial_shmem"

typedef struct {
  unsigned int n;
  unsigned long long result;
} shared_data;

int main() {
  // создание разделяемую память
  int shmem_fd = shmem_open(SHMEM_NAME, O_CREAT | O_RDWR, 0666);
  ftruncate(shmem_fd, sizeof(shared_data));
  shared_data *data = mmap(NULL, sizeof(shared_data), PROT_READ | PROT_WRITE,
                           MAP_SHARED, shmem_fd, 0);

  // Инициализируем данные
  data->n = n;
  data->result = 1;

  // Создаем семафор для синхронизации
  sem_t *sem = sem_open(SEMA_NAME, O_CREAT, 0666, 1);

  // Создаем дочерний процесс
  pid_t pid = fork();

  if (pid == 0) {  // Дочерний процесс
    unsigned long long partial = 1;

    // Вычисляем часть факториала (четные числа)
    for (unsigned int i = 2; i <= data->n; i += 2) {
      partial *= i;
    }

    // Захватываем семафор и обновляем результат
    sem_wait(sem);
    data->result *= partial;
    sem_post(sem);

    exit(0);
  } else if (pid > 0) {  // Родительский процесс
    unsigned long long partial = 1;

    // Вычисляем часть факториала (нечетные числа)
    for (unsigned int i = 1; i <= data->n; i += 2) {
      partial *= i;
    }

    // Захватываем семафор и обновляем результат
    sem_wait(sem);
    data->result *= partial;
    sem_post(sem);

    // Ждем завершения дочернего процесса
    wait(NULL);

    // Выводим результат
    printf("Factorial of %u is %llu\n", data->n, data->result);

    // Освобождаем ресурсы
    munmap(data, sizeof(shared_data));
    shm_unlink(SHMEM_NAME);
    sem_close(sem);
    sem_unlink(SEMA_NAME);
  } else {
    perror("fork failed");
    return 1;
  }

  return 0;
}