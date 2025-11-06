#include <stdio.h>
#include <unistd.h>
#define MAX_LINE 80

int main(void)
{
    char *args[MAX_LINE/2+1];
    int should_run = 1;

    while (should_run)
    {
        printf("LUCAS>");
        fflush(stdout);
        scanf("%s", args);
        printf("args[0]: %s\n", args[0]);
        free(args)
    }

    return 0;
}

