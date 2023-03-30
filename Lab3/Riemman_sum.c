//Brian Sampson
//I pledge my honor that I have abided by the Stevens Honor System.
//CS382 Riemman sum Lab3
//09/21/2022

#include <stdio.h>
#include <stdlib.h>
#include <math.h>


float calculate(float in) {
    return (2.5 * pow(in, 3)) - (15.5 * pow(in, 2)) + (20.0 * in) + 15.0;
}

int main(int argc, char *argv[]) {
    //argv1 is going to be lower bound
    //argv2 is going to be the upper bound
    //argv3 is going to be the amount of initial rectangles

    if(argc != 4) {
        printf("Invailid Arguments.");
        return -1;
    }

    int lowerBound = atoi(argv[1]);
    int upperBound = atoi(argv[2]);
    int rectangles = atoi(argv[3]);

    double const epsilon = 0.0001;

    double oldGuess = 0;
    double newGuess = 0;

    double deltaX = ((upperBound - lowerBound) * 1.0)  / rectangles;


    double sum = 0;
    for (int rec = 0; rec < rectangles; rec++) {
        sum += deltaX * calculate(lowerBound + (rec * deltaX) + deltaX / 2.0);
    }

    rectangles *= 2;
    deltaX = ((upperBound - lowerBound) * 1.0) / rectangles;

    newGuess = sum;
    sum = 0;

    //./a.out 0 1 3 ~20.4
    while(fabs(newGuess - oldGuess) > epsilon) {

        for (int rec = 0; rec < rectangles; rec++) {

        sum += deltaX * calculate(lowerBound + (rec * deltaX) + deltaX / 2.0);
    }
        oldGuess = newGuess;
        newGuess = sum;
        sum = 0;
        
        rectangles *= 2;
        deltaX = ((upperBound - lowerBound) * 1.0) / rectangles;
        
    }
    printf("New Guess: %f, Old Guess: %f, Rectangles: %d\n", newGuess, oldGuess, rectangles);
}
