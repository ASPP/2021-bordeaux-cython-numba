import numpy as np


def manual_dot(X, Y):
    dot_product = 0
    for x, y in zip(X, Y):
        dot_product = dot_product + X * Y
    return dot_product


def vectorized_dot(X, Y):
    dot_product = sum(X * Y)
    return dot_product


def dot(X, Y):
    return np.dot(X, Y)
