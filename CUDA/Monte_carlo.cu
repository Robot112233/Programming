#include <stdlib.h>
#include <stdio.h>
#include <cuda.h>
#include <time.h>
#include <curand_kernel.h>

#define NUMBER               float
#define precision            "float"
#define Cycles               1000
#define Cycles2              512
#define BLOCKS               8
#define THREADS              128
#define Correct_value        187.5

__global__ void gpu_monte_carlo(NUMBER *estimate, curandState *states){
  unsigned int tid = threadIdx.x + blockDim.x * blockIdx.x;
  NUMBER ans, ans2 = 0;
  NUMBER x, y, a, b, c, d;
  a = c = 0;
  b = d = 5;
  curand_init(1234, tid, 0, &states[tid]);

  for (long i = 0; i < Cycles2; i++){
    ans = 0;
    for (long i = 0; i < Cycles; ++i){
      x = (a+(b-a))*curand_uniform(&states[tid]);
      y = (c+(d-c))*curand_uniform(&states[tid]);
      ans += (2*x+y);
    }
    ans2 += ans/(NUMBER)Cycles;
  }
  estimate[tid] = ans2*(((b-a)*(d-c)) / (NUMBER) Cycles2) ;
}

int main (){
  clock_t t[6];
  NUMBER host[BLOCKS * THREADS];
  NUMBER *dev;
  curandState *devStates;
  printf("# of cycles per thread = %d, # of blocks = %d, # of threads/block = %d.\n",
  Cycles, BLOCKS, THREADS);
  t[0] = clock();
  cudaMalloc((void **) &dev, BLOCKS * THREADS * sizeof(NUMBER));
  t[1] = clock();
  cudaMalloc( (void **)&devStates, THREADS * BLOCKS * sizeof(curandState) );
  t[2] = clock();
  gpu_monte_carlo<<<BLOCKS, THREADS>>>(dev, devStates);
  t[3] = clock();
  cudaMemcpy(host, dev, BLOCKS * THREADS * sizeof(NUMBER), cudaMemcpyDeviceToHost);
  t[4] = clock();
  NUMBER integral_gpu;
  for (long i = 0; i < BLOCKS * THREADS; ++i){
    integral_gpu += host[i];
  }
  t[5] = clock();
  integral_gpu /= (NUMBER)(BLOCKS * THREADS);
  printf("Precision %s\n",precision);
  printf("CPU mem allocation  %f  ms.\n", ((t[1]-t[0])*1000.0)/(double)CLOCKS_PER_SEC);
  printf("GPU mem allocation  %f  ms.\n", ((t[2]-t[1])*1000.0)/(double)CLOCKS_PER_SEC);
  printf("GPU Kernel launch  %f  ms.\n", ((t[3]-t[2])*1000.0)/(double)CLOCKS_PER_SEC);
  printf("GPU calculation + copy from GPU mem to CPU mem  %f  ms.\n", ((t[4]-t[3])*1000.0)/(double)CLOCKS_PER_SEC);
  printf("CPU list loop  %f  ms.\n", ((t[4]-t[3])*1000.0)/(double)CLOCKS_PER_SEC);
  printf("CUDA estimate of 2*x+y = %f [error of %f]\n", integral_gpu, integral_gpu - Correct_value);
  return 0;
}
