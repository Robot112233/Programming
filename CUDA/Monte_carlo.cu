
#include <stdlib.h>
#include <stdio.h>
#include <cuda.h>
#include <time.h>
#include <curand_kernel.h>

#define Trials               1000
#define BLOCKS               512
#define THREADS              512
#define Correct_value        187.5


__global__ void gpu_monte_carlo(double *estimate, curandState *states)
{
    unsigned int tid = threadIdx.x + blockDim.x * blockIdx.x;
    double ans = 0;
    double x, y, a, b, c, d;
    a = c = 0;
    b = d = 5;
    curand_init(1234, tid, 0, &states[tid]);

    for (int i = 0; i < Trials; ++i)
    {
        x = (a+(b-a))*curand_uniform(&states[tid]);
        y = (c+(d-c))*curand_uniform(&states[tid]);
        ans += (2*x+y);
    }
    estimate[tid] = ans*(((b-a)*(d-c)) / (double) Trials) ;
}


int main ()
{
    clock_t start, stop;
    double host[BLOCKS * THREADS];
    double *dev;
    curandState *devStates;
    printf("# of trials per thread = %d, # of blocks = %d, # of threads/block = %d.\n",
    Trials, BLOCKS, THREADS);
    start = clock();
    cudaMalloc((void **) &dev, BLOCKS * THREADS * sizeof(double));
    cudaMalloc( (void **)&devStates, THREADS * BLOCKS * sizeof(curandState) );
    gpu_monte_carlo<<<BLOCKS, THREADS>>>(dev, devStates);
    cudaMemcpy(host, dev, BLOCKS * THREADS * sizeof(double), cudaMemcpyDeviceToHost);
    double integral_gpu;
    for (int i = 0; i < BLOCKS * THREADS; ++i)
    {
        integral_gpu += host[i];
    }

    integral_gpu /= (BLOCKS * THREADS);
    stop = clock();
    printf("GPU 2*x+y calculated in %f s.\n", (stop-start)/(double)CLOCKS_PER_SEC);
    printf("CUDA estimate of 2*x+y = %f [error of %f]\n", integral_gpu, integral_gpu - Correct_value);

    return 0;
}
