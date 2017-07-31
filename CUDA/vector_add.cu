#include<stdio.h>

//GPU CODE!
__global__ void add(int *a, int *b, int *c){
  *c = *a + *b;
}
//CPU CODE
int main(void){
  int a, b, c; //host variables
  int *d_a, *d_b, *d_c; //GPU copies of host variables

  a = 9;
  b = 32;

  int size = sizeof(int);

//Allocate space from GPU for host copies
  cudaMalloc((void **) &d_a, size);
  cudaMalloc((void **) &d_b, size);
  cudaMalloc((void **) &d_c, size);

//copy input to GPU
  cudaMemcpy(d_a, &a, size, cudaMemcpyHostToDevice);
  cudaMemcpy(d_b, &b, size, cudaMemcpyHostToDevice);

//GPU kernel launcher
  add<<<1,1>>>(d_a, d_b, d_c);

  //Copy result from GPU
  cudaMemcpy(&c, d_c, size, cudaMemcpyDeviceToHost);

  printf("%d\n",c);

  //cleanup
  cudaFree(d_a);
  cudaFree(d_b);
  cudaFree(d_c);

  return 0;
}
