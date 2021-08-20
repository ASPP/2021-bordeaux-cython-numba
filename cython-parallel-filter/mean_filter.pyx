import cython
from cython.parallel import prange
import numpy as np

@cython.boundscheck(False)
@cython.wraparound(False)
def mean3filter4(double[::] arr):
    cdef double[::] arr_out = np.empty_like(arr)
    cdef int i, N = arr_out.size
    with nogil:
        for i in prange(1, N-1,
                        schedule='static', chunksize=(N-2) // 2, num_threads=2
                        ):
            arr_out[i] = (arr[i-1]+arr[i]+arr[i+1]) / 3
        arr_out[0] = (arr[0] + arr[1]) / 2
        arr_out[N-1] = (arr[N-1] + arr[N-2]) / 2
    return arr_out
