#include "factorial.h"
#include "stdio.h"

int main() {
  unsigned int input = 0;

  scanf("%u", &input);
  printf("%u\n", factorial(input));
}