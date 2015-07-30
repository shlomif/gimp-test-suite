#include "seedserve.h"
#include <glib.h>

GRand*
g_rand_new (void)
{
  return g_rand_new_with_seed(seedserve_get_seed());
}

