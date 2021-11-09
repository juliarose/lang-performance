#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <locale.h>

void quicksort(int number[100000], int first, int last) {
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
                temp=number[i];
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
    int n = 100000;
    int numbers [n];
    int a;
    
    time_t t;
    srand((unsigned) time(&t));
    setlocale(LC_NUMERIC, "");
    
    // generate n random numers ranging from 0 to n
    for (a = 0; a < n; a = a + 1) {
        numbers[a] = rand() % n;
    }
    
    // sort from lowest to highest
    quicksort(numbers, 0, n);
    
    char thousands_numbers [n][9];
    
    // convert each number to a string with thousands separators (e.g. 100,000)
    for (a = 0; a < n; a = a + 1) {
        char str[9];
        sprintf(str, "%'d", numbers[a]);
        strcpy(thousands_numbers[a], str);
    }
    
    return 0;
}