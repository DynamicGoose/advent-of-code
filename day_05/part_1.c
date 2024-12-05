#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main() {
    FILE *inputptr;
    inputptr = fopen("input.txt", "r");

    fseek(inputptr, 0L , SEEK_END);
    long lSize = ftell(inputptr);
    rewind(inputptr);

    // allocate memory for entire input
    char *input_buffer = malloc(lSize + 1);

    // read file to buffer
    if(1 != fread(input_buffer , lSize, 1 , inputptr))
      fclose(inputptr), free(input_buffer), fputs("entire read fails", stderr),exit(1);
    fclose(inputptr);

    // parsing
    char *rules, *update;
    rules = strtok(input_buffer, "---");
    update = strtok(NULL, "---");

    printf("%s", rules);

    return 0;
}
