from math import sin

# Function tabulation range
FROM, TO = 1, 4
# Tabulation step(count)
N = 1000

# Function itself
def int_f(x: float) -> float:
    return sin(100*x)/x**2


def integrate(n: int) -> float:
    dx = (TO - FROM) / n
    integral = 0.5 * (int_f(FROM) + int_f(TO))

    for i in range(1, n):
        integral += int_f(FROM + i * dx)

    return integral * dx

f = integrate
