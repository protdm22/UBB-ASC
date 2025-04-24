// 13. Three strings of characters are given. Show the longest common suffix for each of the three pairs of two strings that can be formed

#include <stdio.h>

char* get_suffix(const char*, const char*);

int main() {
    char s1[101], s2[101], s3[101];
    printf("Enter the first string: ");
    scanf("%100s", s1);
    printf("Enter the second string: ");
    scanf("%100s", s2);
    printf("Enter the third string: ");
    scanf("%100s", s3);
    printf("Longest suffix between %s and %s is %s\n", s1, s2, get_suffix(s1,s2));
    printf("Longest suffix between %s and %s is %s\n", s1, s3, get_suffix(s1,s3));
    printf("Longest suffix between %s and %s is %s\n", s2, s3, get_suffix(s2,s3));
    return 0;
}
