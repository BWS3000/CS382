#include <stdio.h>

int main() {
    int number = 1;
    char charecter = 'k';
    int sum;
    sum = number + charecter;
    printf("Value of sum : %d\n", sum);


    int i = 5/3;
    float f = 5/3;
    
    printf("helloWorld!");

    float new1 = 5*1.0+2;
    float new2 = 1/3+1/3+1/3;
    printf("print new1 %f\n", new1);
    printf("print new2 %f\n", new2);

    printf("Value of i: %d\n", i);
    printf("Value of f: %f\n", f);

    printf("Value of sum: %d\n", sum);
    
    //Print all variables
    printf("The variables are: %d\n %f\n %d\n", i, f, charecter);
    
    return 0;


}