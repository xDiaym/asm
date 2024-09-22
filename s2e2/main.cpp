#include <iostream>
#include <format>

float int_f(float x) { return x; }

float integrate(int n) {
    float dx = (4 - 1) / n + 1;
    float s = 0.0;
    float x0 = 1, x1 = 1 + dx;
    float f0 = int_f(x0), f1 = int_f(x1);

    for (int i = 0; i < n; ++i) {
        s += (f0 + f1) / 2 * dx;
        
        x0 = x1;
        x1 += dx;
        f0 = f1;
        f1 = int_f(x1);
    }

    return s;
}

int main() {
    for (int i = 1; i < 100; i++) {
        std::cout << std::format("{}: {} {}\n", i, integrate(i), 8-0.5);
    }
}