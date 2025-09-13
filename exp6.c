#include <stdio.h>
#include <string.h>

struct code {
    char l[10], r[20];
} c[10];

int main() {
    int i, j, n;

    printf("Enter number of statements: ");
    scanf("%d", &n);

    for(i = 0; i < n; i++) {
        printf("Enter statement %d (e.g., a=b+c): ", i+1);
        scanf("%s", c[i].l);   // read full statement (like a=b+c)

        // split into LHS and RHS
        char *eq = strchr(c[i].l, '=');
        if(eq != NULL) {
            *eq = '\0'; // split string into two parts
            strcpy(c[i].r, eq+1); // RHS
        } else {
            strcpy(c[i].r, "");
        }
    }

    printf("\n------ Intermediate Code ------\n");
    for(i = 0; i < n; i++)
        printf("%s=%s\n", c[i].l, c[i].r);

    // Dead Code Elimination
    for(i = 0; i < n-1; i++) {
        for(j = i+1; j < n; j++) {
            if(strcmp(c[i].l, c[j].l) == 0) {
                strcpy(c[i].l, "");  // eliminate dead statement
                strcpy(c[i].r, "");
                break;
            }
        }
    }

    printf("\n------ After Dead Code Elimination ------\n");
    for(i = 0; i < n; i++) {
        if(strcmp(c[i].l,"") != 0)
            printf("%s=%s\n", c[i].l, c[i].r);
    }

    // Common Subexpression Elimination
    for(i = 0; i < n-1; i++) {
        if(strcmp(c[i].l,"") == 0) continue;
        for(j = i+1; j < n; j++) {
            if(strcmp(c[i].r, c[j].r) == 0 && strcmp(c[j].r,"") != 0) {
                printf("\nEliminating common expression: %s\n", c[j].r);
                strcpy(c[j].r, c[i].l); // reuse result of earlier computation
            }
        }
    }

    printf("\n------ Optimized Code ------\n");
    for(i = 0; i < n; i++) {
        if(strcmp(c[i].l,"") != 0)
            printf("%s=%s\n", c[i].l, c[i].r);
    }

    return 0;
}