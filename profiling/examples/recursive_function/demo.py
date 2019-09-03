import time


def my_awesome_recursive(i=0):
    time.sleep(0.1)
    if i == 100:
        return i
    else:
        return my_awesome_recursive(i + 1)


if __name__ == "__main__":
    my_awesome_recursive()
