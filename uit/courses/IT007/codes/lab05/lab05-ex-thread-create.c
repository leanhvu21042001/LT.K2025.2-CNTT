#include <stdio.h>
#include <pthread.h>
#include <semaphore.h>

int sells = 0, products = 0;
sem_t sem;

void *CONSUMER(void* message)
{
    while(1)
    {
        sem_wait(&sem);
        sells++;
        printf("COSUMER | sells = %d\n", sells);
    }
}

void *PRODUCER(void* message)
{
    while(1)
    {
        products++;
        sem_post(&sem);
        printf("PRODUCER | products = %d\n", products);
    }
}

int main()
{
    pthread_t idthread1, idthread2;
    sem_init(&sem, 0, 0);

    pthread_create(
        &idthread1,
        NULL,
        &CONSUMER,
        NULL);

    pthread_create(
        &idthread2,
        NULL,
        &PRODUCER,
        NULL);

    while(1);

    return 0;
}

