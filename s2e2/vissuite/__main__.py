#!/usr/bin/env python3
from collections.abc import Callable
from dataclasses import dataclass
from functools import wraps
from pathlib import Path
from typing import TypedDict
import matplotlib
import matplotlib.pyplot as plt
from argparse import ArgumentParser
import io
import sys
import subprocess
from csv import DictReader

from config import FROM, TO, N, f


ROOT = Path(__file__).resolve().parent.parent
CONFIG_PATH = ROOT / "config"
PLOT_OUT_PATH = ROOT / "plot"
PLT_BACKEND = "QtAgg"

PLOT_OUT_PATH.mkdir(parents=True, exist_ok=True)


def use_nan(func: Callable[[float], float]) -> Callable[[float], float]:
    @wraps(func)
    def wrapper(x: float) -> float:
        try:
            return func(x)
        except (ValueError, ZeroDivisionError):  # type: ignore
            return float("nan")

    return wrapper


class Tabulature(TypedDict):
    x: list[int]
    f: list[float]


@dataclass
class Config:
    from_: float
    to: float
    N: int
    f: Callable[[int], float]

    @property
    def iters(self) -> int:
        return self.N


def run_lab(args: list[str]) -> int:
    with subprocess.Popen(args, stdout=subprocess.PIPE) as proc:
        stdout = proc.communicate()[0].decode()
    return stdout


def read_csv(fp: io.FileIO) -> Tabulature:
    reader = DictReader(fp)
    mapping = {"x": [], "f": []}
    for line in reader:
        mapping["x"].append(int(line["x"]))
        mapping["f"].append(float(line["f"]))
    return mapping


def generate_exact(config: Config) -> Tabulature:
    tab = {"x": [], "f": []}

    for n in range(1, config.iters):
        tab["x"].append(n)
        tab["f"].append(config.f(n))

    return tab


def plot(
    asm: Tabulature, exact: Tabulature, interactive: bool, config: Config
) -> None:
    if interactive:
        matplotlib.use(PLT_BACKEND)

    plt.plot(asm["x"], asm["f"], label="asm")
    plt.plot(exact["x"], exact["f"], label="exact")
    plt.legend()

    if interactive:
        plt.show()
    else:
        plt.savefig(PLOT_OUT_PATH / "plot.png")


def run(exe: Path, interactive: bool, config: Config) -> None:
    stdout = run_lab([exe, str(config.N)])
    asm = read_csv(io.StringIO(stdout))
    exact = generate_exact(config)
    plot(asm, exact, interactive, config)


def main() -> int:
    parser = ArgumentParser()
    parser.add_argument("exe", type=Path)
    parser.add_argument("-n", type=int, default=None)
    parser.add_argument("-i", "--interactive", action="store_true")
    args = parser.parse_args()

    config = Config(from_=FROM, to=TO, N=N, f=use_nan(f))
    config.N = args.n or config.N

    try:
        run(args.exe, args.interactive, config)
    except Exception as exc:
        print(exc)
        return -1
    return 0


if __name__ == "__main__":
    sys.exit(main())
