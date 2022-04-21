#include <stdio.h>
#include <string.h>
#include <ctype.h>

// https://stackoverflow.com/questions/352055/best-algorithm-to-strip-leading-and-trailing-spaces-in-c
char *strstrip(char *s)
{
    size_t size;
    char *end;

    size = strlen(s);

    if (!size)
        return s;

    end = s + size - 1;
    while (end >= s && isspace(*end))
        end--;
    *(end + 1) = '\0';

    while (*s && isspace(*s))
        s++;

    return s;
}

int main () {
    char str[] = "            The President of the United States   ";
    
    for (int i = 0; i < 1000000; i++) {
        char* ptr = strstrip(str);
    }
    
    return 0;
}
