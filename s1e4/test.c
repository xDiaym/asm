#include <stdio.h>
#include <string.h>
#include <assert.h>

extern char* asm_strtok(char *str, const char *delim);

extern size_t asm_strspn(const char* dst, const char* src);
extern size_t asm_strcspn(const char* dst, const char* src);

int main() {
  assert(asm_strspn("hello world", "hleo") == 5);
  assert(asm_strspn("hello world", NULL) == 0);
  assert(asm_strspn("hhhhh world", "h") == 5);

  assert(asm_strcspn("hello world", "word") == 4);
  assert(asm_strcspn("hello world", NULL) == 11);
  assert(asm_strcspn("hhhhh world", "h") == 0);
  assert(asm_strcspn("world hhhhh", "h") == 6);


  char str[] = "hello world!";
  assert(asm_strtok(str, " ") == str);
  assert(asm_strtok(NULL, " !") == str + 6);
  assert(asm_strtok(NULL, " !") == NULL);

  assert(asm_strtok(NULL, NULL) == NULL);
  assert(asm_strtok(str, NULL) == str);

  return 0;
}
