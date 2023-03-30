#include <stdio.h>
#include <stdlib.h>
#include <math.h>

// the function to be integrated
double func(double x)
{
    double f = (2.5*x*x*x - 15.5*x*x + 20*x + 15);
    return f;
}

double midpoint(double a, double b, double n)
{
    double w = (b-a)/n; // width
    double result = 0.0;
    for(double x=a+w/2; x<b; x+=w)
    {
        double y = func(x);
        result += y*w;
    }
    return result;
}

int main(int argc, char *argv[]) 
{
    if(argc != 4)
    {
        printf("Invalid number of arguments.");
        return 1;
    }
    
    double a = atof(argv[1]);
    double b = atof(argv[2]);
    int n = atof(argv[3]);
    if (a > b)
    {
        printf("Lower bound cannot be greater than upper bound.");
        return 1;
    }
    
    double ap1 = midpoint(a, b, n);
    n = n*2;
    double ap2 = midpoint(a, b, n);
    while (fabs(ap2 - ap1) > 1e-4)
    {
        n = n*2;
        ap1 = ap2;
        ap2 = midpoint(a,b,n);
    }
    printf("Number of rectangles: %d \n", n);
    printf("Previous Approximation: %f \n", ap1);
    printf("Current Approximation: %f \n", ap2);
    
    return 0;
}
