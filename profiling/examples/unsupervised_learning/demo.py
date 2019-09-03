# For this example to run, you also need the 'ica.py' file

import numpy as np
from scipy import linalg

from ica import fastica


def test():
    """
    This is a combination of two unsupervised learning techniques, principal
    component analysis (PCA) and independent component analysis (ICA). PCA is
    a technique for dimensionality reduction, i.e. an algorithm to explain the
    observed variance in your data using less dimensions. ICA is a source
    separation technique, for example to unmix multiple signals that have been
    recorded through multiple sensors. Doing a PCA first and then an ICA can
    be useful if you have more sensors than signals. For more information see:
    the FastICA example from scikit-learn.
    """

    data = np.random.random((5000, 100))
    u, s, v = linalg.svd(data)
    pca = np.dot(u[:, :10].T, data)
    results = fastica(pca.T, whiten=False)
    return results


if __name__ == '__main__':
    test()
