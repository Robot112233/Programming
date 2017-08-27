//Neural network || Work in progress
#include "random.h"
#include <stdio.h>

#define SIZE(x) (sizeof(x) / sizeof((x)[0]))
#define function(x) (2*x+1)
#define COUNTS 30
//------------------------------------------------------------------------------
struct memory{
  float storage;
};
struct memory x[COUNTS];
struct memory y[COUNTS];
struct memory weight[COUNTS];
struct memory answer[COUNTS];
//------------------------------------------------------------------------------
float random(){
  long int idums = -1;
  long int *idum = &idums;
  float random = ran2(idum);
  return random;
}
//------------------------------------------------------------------------------
void inputs_weights(){
  int i;
  for ( i = 0; i < COUNTS; i++) {
    y[i].storage = 5*random();
    x[i].storage = random();
    weight[i].storage = 0.1;
  }
}
//------------------------------------------------------------------------------
void guess(){
  int i;
  float summ = 0;
  for ( i = 0; i < COUNTS; i++) {
    summ  = y[i].storage*weight[i].storage;
    if (summ > 1) answer[i].storage = 1;
    else answer[i].storage = -1;
  }
}
//------------------------------------------------------------------------------
void trainer(){
  int i;
  float y_real;
  for (i = 0; i < COUNTS; i++) {
    y_real = function(x[i].storage);
    if (y_real > y[i].storage) answer[i].storage = -1;
    else answer[i].storage = 1;
  }
}
//------------------------------------------------------------------------------
int main(){
  inputs_weights();
  guess();
  trainer();
  int i;
  for (i = 0; i < COUNTS; i++) {
    printf("x %f y %f up/down %f correct y %f \n",x[i].storage,y[i].storage,answer[i].storage,function(x[i].storage));
  }
  return 0;
}
