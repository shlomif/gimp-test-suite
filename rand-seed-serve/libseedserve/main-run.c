#include <stdio.h>

#include "seedserve.h"

int main(int argc, char * argv[])
{
    printf("%i\n", seedserve_get_seed());
    return 0;
}
