#include <stdio.h>
#include <signal.h>

int loop_forever = 1;

void on_sigint()
{
    printf("Leu leu\n");
    // loop_forever = 0;
}

void main()
{
    signal(SIGINT, on_sigint);

    while(loop_forever);
}

