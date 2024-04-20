#include <stdio.h>
#include <string.h>
#include <assert.h>

extern char* asm_strtok(char *str, const char *delim);

extern size_t asm_strspn(const char* dst, const char* src);

int main() {
  assert(asm_strspn("hello world", "hleo") == 5);
  assert(asm_strspn("hello world", NULL) == 0);
  assert(asm_strspn("hhhhh world", "h") == 5);

  assert(asm_strtok(NULL, NULL) == NULL);
  return 0;
}
