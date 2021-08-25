import numpy as np 
 
import cython 

@cython.boundscheck(False) 
@cython.wraparound(False) 
def mean3filter(double[:] arr): 
    cdef double[:] arr_out = np.empty_like(arr) 
    cdef size_t i 
    cdef size_t N = arr.shape[0] 
    for i in range(1, N - 1): 
        arr_out[i] = (arr[i-1]+arr[i]+arr[i+1]) / 3 
    arr_out[0] =  (arr[0] + arr[1]) / 2 
    arr_out[N-1] = (arr[N-2] + arr[N-1]) / 2 
    return arr_out
