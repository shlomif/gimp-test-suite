#include <glib.h>

int main()
{
    GRand * gr;
    int i;

    gr = g_rand_new();

    for(i=0;i<100;i++)
    {
        printf("%i\n", g_rand_int(gr));
    }
    
    g_rand_free(gr);

    return 0;
}
