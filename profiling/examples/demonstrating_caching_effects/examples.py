import numpy as np

c = np.zeros((1e4, 1e4), order='C')
c.sum(axis=0)
c.sum(axis=1)
