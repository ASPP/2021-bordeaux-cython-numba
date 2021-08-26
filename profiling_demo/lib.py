def f(x):
    y = x ** 4 - 3 * x
    return y


def integrate_f(a, b, n):
    dx = (b - a) / n
    dx2 = dx / 2
    s = f(a) * dx2
    i = 0
    for i in range(1, n):
        s += f(a + i * dx) * dx
    s += f(b) * dx2
    return s
