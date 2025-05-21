#include "factorial.h"

unsigned int factorial(unsigned int n) {
  int fact = 1;

  for (unsigned int i = 1; i <= n; i++) fact *= i;

  return fact;
}