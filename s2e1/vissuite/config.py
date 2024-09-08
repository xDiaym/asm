from math import cos, log, pi

# Function tabulation range
FROM, TO = -2, 2
# Tabulation step(dx)
STEP = 1e-2

A = 2.0

# Function itself
def f(x: float) -> float:
    return (log(abs(x - A / 2)) + cos(x * pi / (3 * A))) / (1 + x / A + x**2 / 2)
