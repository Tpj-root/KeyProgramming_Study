#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define MAX_VALUES 42
#define PIN_LENGTH 6
#define MAX_COUNT 6000000  // Stop after 10,000 PINs

unsigned char hex_values[MAX_VALUES] = {
    0x00, 0xa0, 0xb1, 0xc1, 0xc2, 0xcd, 0xe3, 0xf2, 0xff, 0x01,
    0x1d, 0x1f, 0x02, 0x4a, 0x4c, 0x4d, 0x5a, 0x07, 0x8c, 0x8d,
    0x8f, 0x10, 0x21, 0x22, 0x30, 0x31, 0x32, 0x34, 0x36, 0x37,
    0x38, 0x41, 0x45, 0x46, 0x48, 0x49, 0x52, 0x53, 0x59, 0x60,
    0x62, 0x98
};

int done = 0;

void generate(int depth, int used[], unsigned char pin[], unsigned long *count) {
    if (*count >= MAX_COUNT || done) return;

    if (depth == PIN_LENGTH) {
        (*count)++;
        printf("%02X:%02X:%02X:%02X:%02X:%02X\n", pin[0], pin[1], pin[2], pin[3], pin[4], pin[5]);
        if (*count >= MAX_COUNT) done = 1;
        return;
    }

    for (int i = 0; i < MAX_VALUES && !done; i++) {
        if (!used[i]) {
            used[i] = 1;
            pin[depth] = hex_values[i];
            generate(depth + 1, used, pin, count);
            used[i] = 0;
        }
    }
}

int main() {
    clock_t start = clock();
    unsigned long count = 0;
    int used[MAX_VALUES] = {0};
    unsigned char pin[PIN_LENGTH];

    generate(0, used, pin, &count);

    double elapsed = (clock() - start) / (double)CLOCKS_PER_SEC;
    printf("Generated %lu PINs in %.2f seconds.\n", count, elapsed);
    return 0;
}
