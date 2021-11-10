#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <locale.h>

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
        char str[10];
        sprintf(str, "%'d", numbers[i]);
        thousands_numbers[i] = malloc(sizeof(char) * 10);
        strcpy(thousands_numbers[i], str);
    }
    
    // free the memory
    free(numbers);
    
    for (i = 0; i < n; i = i + 1) {
        free(thousands_numbers[i]);
    }
    
    return 0;
}
