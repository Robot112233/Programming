#include<stdio.h>
#include<stdlib.h>

#define LOOP 10000000
#define N 1
#define X_max 5.0
#define X_min 0.0
#define Y_max 5.0
#define Y_min 0.0
//GPU CODE!
__global__ void add(double *C_inputA, double *C_inputB, double *C_output){
  for (int i = 0; i < LOOP; i++) {
    C_output[0] = C_output[0]+2*C_inputA[blockIdx.x]+C_inputB[blockIdx.x];
  }
}

void var_A(double* C_inputA){
  for (int i = 0; i < LOOP; ++i){
    double d = rand()/(double)RAND_MAX;
    C_inputA[i] = X_min+(X_max-X_min)*d;
  }
}
void var_B(double* C_inputB){
  for (int i = 0; i < LOOP; ++i){
    double d = rand()/(double)RAND_MAX;
    C_inputB[i] = Y_min+(Y_max-Y_min)*d;
  }
}

//CPU CODE
int main(void){
  srand (time(0));

  double *C_inputA, *C_inputB, *C_output; //host copies of variables
  double *G_inputA, *G_inputB, *G_output; //GPU copies of host variables
  double size = LOOP*N * sizeof(double);

//Allocate space from GPU for host copies
  cudaMalloc((void **) &G_inputA, size);
  cudaMalloc((void **) &G_inputB, size);
  cudaMalloc((void **) &G_output, size);

//Allocate space for cpu copies
  C_inputA = (double *)malloc(size); var_A(C_inputA);
  C_inputB = (double *)malloc(size); var_B(C_inputB);
  C_output = (double *)malloc(size);

//copy input to GPU
  cudaMemcpy(G_inputA, C_inputA, size, cudaMemcpyHostToDevice);
  cudaMemcpy(G_inputB, C_inputB, size, cudaMemcpyHostToDevice);

//GPU kernel launcher
  add<<<N,1>>>(G_inputA, G_inputB, G_output);

  //Copy result from GPU
  cudaMemcpy(C_output, G_output, size, cudaMemcpyDeviceToHost);
  double ans = *C_output;
  ans = (((X_max-X_min)*(Y_max-Y_min))/LOOP)*ans;
  printf("%e\n",ans);
  //cleanup
  free(C_inputA);
  free(C_inputB);
  free(C_output);
  cudaFree(G_inputA);
  cudaFree(G_inputB);
  cudaFree(G_output);

  return 0;
}
