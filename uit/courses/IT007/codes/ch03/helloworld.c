#include <stdio.h>
#define HELLO "UIT"

int add (int a, int b)
{
    int c = a + b;
    return c;
}

int main() {
    int x = 10, y = 20;
    int z = add(x, y);

    printf("Gia tri cua z la: %d\n", z);
    
    return 0;
}

