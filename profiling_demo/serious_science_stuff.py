import pickle

from lib import integrate_f


if __name__ == "__main__":

    # set integration bounds
    a = -100
    b = 100

    # integrate function f for different bin counts
    bin_counts = [10, 100, 1_000, 10_000, 100_000]
    results = []
    for n in bin_counts:
        r = integrate_f(a, b, n)
        results.append(r)

    # print and store results
    print(list(zip(bin_counts, results)))
    with open("result.pkl", "wb") as f:
        pickle.dump(results, f)
