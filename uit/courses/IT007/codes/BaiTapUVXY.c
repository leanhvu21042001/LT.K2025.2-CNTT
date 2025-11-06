#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>
#include <sys/types.h>

int main()
{
    int a = 10;

    if (fork() == 0)
    {
        a = a + 5;
        printf("x = %d, y = %d\n", a, &a);
    }
    else
    {
        a = a - 5;
        printf("u = %d, v = %d\n", a, &a);
    }

    return 0;
}

