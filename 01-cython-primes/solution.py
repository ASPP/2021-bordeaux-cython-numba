%%cython -a

import cython

@cython.cdivision(True)
def nth_prime(int n):
    cdef:
        int n_found = 0
        int candidate = 2
        bint good
        int div
    while True:
        good = True
        for div in range(2, candidate):
            if candidate % div == 0:
                good = False
                break
        if good:
            n_found += 1
            if n_found == n:
                return candidate
        # try with the next number
        candidate += 1
