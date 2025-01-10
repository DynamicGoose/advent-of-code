#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define NUM_ROWS 1400
#define NUM_COLS 80
#define MAX_UPDATES 24 // maximum number of updates per line in input

int find_idx(int num, int *page) {
    int idx = 0;
    while (1) {
        if (page[idx] == -1 && num != -1)
            return -1;
        if (page[idx] == num)
            return idx;
        idx++;
    }
}

int main() {
    // parsing input
    char** table = malloc(NUM_ROWS * sizeof(char*));
    for (int i = 0; i < NUM_ROWS; ++i)
        table[i] = malloc(NUM_COLS * sizeof(char));

    char * buf = NULL;
    size_t len = 0;
    int num_lines = 0;

    if (freopen("../inputs/05.txt", "r", stdin) == NULL)
        exit(1);

    while (getline(&buf, &len, stdin) != -1 && num_lines < NUM_ROWS) {
        strncpy(table[num_lines], buf, NUM_COLS);
        table[num_lines][NUM_COLS - 1] = '\0';
        num_lines++;
    }

    free(buf);
    fclose(stdin);

    // get rules and pages
    int** rules = malloc(num_lines * sizeof(int*));
    for (int i = 0; i < num_lines; ++i)
        rules[i] = malloc(2 * sizeof(int));

    int** page_updates = malloc(num_lines * sizeof(int*));
    for (int i = 0; i < num_lines; ++i)
        page_updates[i] = malloc(MAX_UPDATES * sizeof(int));

    int rule_count = 0, page_count = 0, part = 0;
    for (int i = 0; i < num_lines; ++i) {
        if (strlen(table[i]) == 1) {
            part = 1;
            continue;
        }
        if (!part) {
            char *first = strtok(table[i], "|");
            char *second = strtok(NULL, "\n");
            if (first && second) {
                rules[rule_count][0] = atoi(first);
                rules[rule_count][1] = atoi(second);
                rule_count++;
            }
        } else {
            int col = 0;
            for (char *update = strtok(table[i], ","); update != NULL; update = strtok(NULL, ","))
                page_updates[page_count][col++] = atoi(update);
            page_updates[page_count][col] = -1;
            page_count++;
        }
    }

    // calculate result
    int result = 0;
    for (int i = 0; i < page_count; i++) {
        int *page = page_updates[i];
        int idx = find_idx(-1, page) / 2;

        // is sorted?
        int n = find_idx(-1, page);
        int is_sorted = 1;
        if (n != -1) {
            for (int j = 0; j < n -1; ++j) {
                int swapped = 0;
                for (int k = 0; k < n - j - 1; ++k) {
                    int need_swap = 0;

                    for (int l = 0; l < rule_count; l++) {
                        if (rules[l][0] == page[k] && rules[l][1] == page[k + 1])
                            break;
                        if (rules[l][1] == page[k] && rules[l][0] == page[k + 1]) {
                            need_swap = 1;
                            break;
                        }
                    }

                    if (need_swap) {
                        is_sorted = 0;
                        int tmp = page[k];
                        page[k] = page[k + 1];
                        page[k + 1] = tmp;
                        swapped = 1;
                    }
                }
                if (!swapped) break;
            }
        }
        if (is_sorted)
            result += page_updates[i][idx];
    }
    printf("%d\n", result);

    // free
    for (int i = 0; i < NUM_ROWS; ++i)
        free(table[i]);
    free(table);

    for (int i = 0; i < num_lines; ++i) {
        free(rules[i]);
        free(page_updates[i]);
    }
    free(rules);
    free(page_updates);

    return 0;
}
