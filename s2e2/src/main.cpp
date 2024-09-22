#include <format>
#include <iostream>

extern "C" float f(int);  // NOLINT

static constexpr float kStart = 1.0f;
static constexpr float kEnd = 4.0f;

void GenerateCSVReport(std::size_t n) {
  std::cout << "x,f\n";
  for (std::size_t i = 0; i < n; ++i) {
    std::cout << std::format("{},{}\n", i, f(i));
  }
}

int main(int argc, char** argv) {
  if (argc < 2) {
    std::cout << std::format("usage: {} <n>\n", argv[0]);
    return -1;
  }

  const auto n = std::atoi(argv[1]);
  GenerateCSVReport(n);

  return 0;
}
