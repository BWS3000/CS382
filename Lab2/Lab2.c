//Brian Sampson
//I pledge my honor that I have abided by the Stevens Honor System.

#include <stdio.h>
#include <stdlib.h>

void display(int8_t bit) {
    putchar(bit + 48);
}

void display_32(int32_t num) {
    /* My code */
    int output, c;

    for (int c = 31; c >= 0; c--) {
        output = num >> c;

        if (output & 1) {
            display(1);
        } else {
            display(0);
        }
    }
}

int main (int argc, char const *argv[]) {
    int32_t x = 382;

    printf("Decimal: %d\n", x);
    printf("Binary: ");
    display_32(x);
    printf("\n");
    

    if (argc > 1) {
        int32_t input = atoi(argv[1]);
        printf("Decimal: %d\n", input);
        printf("Binary: ");
        display_32(input);
        printf("\n");
    }

    return 0;
}

