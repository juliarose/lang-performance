#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <locale.h>
#include <limits.h>

void quicksort(int *numbers, int first, int last) {
    int i, j, pivot, temp;
    
    if (first < last) {
        pivot = first;
        i = first;
        j = last;
        
        while (i < j) {
            while (numbers[i] <= numbers[pivot] && i < last) {
                i++;
            }
            
            while (numbers[j] > numbers[pivot]) {
                j--;
            }
            
            if (i < j) {
                temp = numbers[i];
                numbers[i] = numbers[j];
                numbers[j] = temp;
            }
        }
        
        temp = numbers[pivot];
        numbers[pivot]=numbers[j];
        numbers[j] = temp;
        quicksort(numbers, first, j - 1);
        quicksort(numbers, j + 1, last);
    }
}

int numPlaces(int n) {
    if (n < 0) n = (n == INT_MIN) ? INT_MAX : -n;
    if (n < 10) return 1;
    if (n < 100) return 2;
    if (n < 1000) return 3;
    if (n < 10000) return 4;
    if (n < 100000) return 5;
    if (n < 1000000) return 6;
    if (n < 10000000) return 7;
    if (n < 100000000) return 8;
    if (n < 1000000000) return 9;
    
    return 10;
}

int main () {
    time_t t;
    srand((unsigned) time(&t));
    setlocale(LC_NUMERIC, "");
    
    int n = 1000000;
    int *numbers = malloc(n * sizeof(int));
    int i;
    
    // generate n random numbers ranging from 0 to n
    for (i = 0; i < n; i = i + 1) {
        numbers[i] = rand() % (n + 1);
    }
    
    // sort from lowest to highest
    quicksort(numbers, 0, n);
    
    char *thousands_numbers[n];
    
    // convert each number to a string with thousands separators (e.g. 100,000)
    for (i = 0; i < n; i = i + 1) {
        int digits = numPlaces(numbers[i]);
        int num_commas = (digits - 1) / 3;
        // number of digits, number of commas, and null terminator
        int len = digits + num_commas + 1;
        
        thousands_numbers[i] = malloc(sizeof(char) * len);
        snprintf(thousands_numbers[i], 10, "%'d", numbers[i]);
    }
    
    // printf("%s\n", thousands_numbers[n / 2]);
    // free the memory
    free(numbers);
    
    for (i = 0; i < n; i = i + 1) {
        free(thousands_numbers[i]);
    }
    
    return 0;
}
