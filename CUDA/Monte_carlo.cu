#include <stdlib.h>
#include <stdio.h>
#include <cuda.h>
#include <time.h>
#include <curand_kernel.h>

#define NUMBER               float
#define precision            "float"
#define Kernel_cycles        10000
#define Cycles               512
#define Cycles2              512
#define BLOCKS               8
#define THREADS              128
#define Correct_value        187.5

__global__ void gpu_monte_carlo(NUMBER *estimate, curandState *states, int seed){
  unsigned int tid = threadIdx.x + blockDim.x * blockIdx.x;
  NUMBER ans, ans2 = 0;
  NUMBER x, y, a, b, c, d;
  a = c = 0;
  b = d = 5;
  curand_init(seed, tid, 0, &states[tid]);

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


int main(){
  clock_t t[2];
  cudaStream_t stream1;
  cudaStreamCreate(&stream1);
  //variables and pointers
  NUMBER host[BLOCKS * THREADS];
  NUMBER *dev;
  curandState *devStates;
  int seed = 1;
  double integral_gpu;
  printf("# of cycles per kernel = %d, # of blocks = %d, # of threads/block = %d.\n",
  Kernel_cycles, BLOCKS, THREADS);
  cudaMalloc((void **) &dev, BLOCKS * THREADS * sizeof(NUMBER));
  cudaMalloc( (void **)&devStates, THREADS * BLOCKS * sizeof(curandState) );
  t[0] = clock();

  for (long i = 0; i < Kernel_cycles; i++) {
    seed +=1;
    gpu_monte_carlo<<<BLOCKS, THREADS,1,stream1>>>(dev, devStates, seed);
    cudaMemcpy(host, dev, BLOCKS * THREADS * sizeof(NUMBER), cudaMemcpyDeviceToHost);
    for (long i = 0; i < BLOCKS * THREADS; ++i){
      integral_gpu += host[i];
    }

  }
  t[1] = clock();
  integral_gpu /= (BLOCKS * THREADS * (long)Kernel_cycles);
  printf("Precision %s\n",precision);
  printf("GPU calculation  %f  s.\n", ((t[1]-t[0]))/(double)CLOCKS_PER_SEC);
  printf("CUDA estimate of 2*x+y = %f [error of %f]\n", integral_gpu, integral_gpu - Correct_value);

  cudaFree(dev);
  cudaFree(devStates);
  return 0;
}

