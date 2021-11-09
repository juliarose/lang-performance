#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <locale.h>

void quicksort(int number[1000000], int first, int last) {
    int i, j, pivot, temp;
    
    if (first < last) {
        pivot = first;
        i = first;
        j = last;
        
        while (i < j) {
            while (number[i] <= number[pivot] && i < last) {
                i++;
            }
            
            while (number[j] > number[pivot]) {
                j--;
            }
            
            if (i < j) {
                temp = number[i];
                number[i] = number[j];
                number[j] = temp;
            }
        }
        
        temp = number[pivot];
        number[pivot]=number[j];
        number[j] = temp;
        quicksort(number, first, j - 1);
        quicksort(number, j + 1, last);
    }
}

int main () {
    int n = 1000000;
    int *numbers = malloc(n * sizeof(int));
    int i;
    
    time_t t;
    srand((unsigned) time(&t));
    setlocale(LC_NUMERIC, "");
    
    // generate n random numbers ranging from 0 to n
    for (i = 0; i < n; i = i + 1) {
        numbers[i] = rand() % n;
    }
    
    // sort from lowest to highest
    quicksort(numbers, 0, n);
    
    char *thousands_numbers[n];
    
    // convert each number to a string with thousands separators (e.g. 100,000)
    for (i = 0; i < n; i = i + 1) {
        char str[10];
        sprintf(str, "%'d", numbers[i]);
        thousands_numbers[i] = (char *)malloc(sizeof(char[10]));
        strcpy(thousands_numbers[i], str);
    }
    
    free(numbers);
    
    return 0;
}
