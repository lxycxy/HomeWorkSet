import matplotlib.pyplot as plt
import numpy as np


def drawCS():
    fig = plt.figure()
    x = np.linspace(-2 * np.pi, 2 * np.pi, 100)

    # x1 = fig.add_subplot()
    # x2 = fig.add_subplot()
    # x3 = fig.add_subplot()

    # x1 = x2 = x3 = x

    y = 2500 / x


    plt.plot(x, y , linestyle='-.' )
    plt.show()

    return


def main():
    

    print("FK 卢裕中\n" * 114514)

    return

if __name__ == '__main__':
    main()