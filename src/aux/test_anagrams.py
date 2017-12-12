"""
Integration test a program that should determine if things are anagrams
"""

import argparse
import string
import subprocess
import time
import re
import sys

from random import randrange, choice, shuffle, sample

def strip_suffix(script):
    return re.match(r"(.*)\.pas", script).group(1)

def get_args():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("files", nargs="*", type=str,
                                    help="Pascal files to test")
    return parser.parse_args()

def get_anagrams(length, num):
    for _ in range(num):
        word = [choice(string.ascii_uppercase) for _ in range(length())]
        copy = word[:]
        shuffle(copy)
        yield map("".join, [word, copy])

def get_nonanagrams(length, num):
    for _ in range(num):
        word = [randrange(len(string.ascii_uppercase)) for _ in range(length())]
        copy = word[:]
        shuffle(copy)
        copy[randrange(len(copy))] += randrange(1, len(string.ascii_uppercase))
        yield ("".join(string.ascii_uppercase[i % len(string.ascii_uppercase)]
                                        for i in j) for j in (word, copy))

def test_correct(script, generator, expected):
    exec_path = "bin/{}".format(strip_suffix(script))
    comp = subprocess.Popen(
                ["fpc", script, "-o{}".format(exec_path), "-Tlinux"],
                            stdout=subprocess.PIPE,
                            stderr=subprocess.PIPE)
    out, err = comp.communicate()
    if comp.returncode:
        sys.exit("\ncritical {}".format(err))
    passes, fails = 0, 0
    timings = [0] * 7
    for length in range(1, 8):
        for a, b in generator(
                    lambda: randrange(1 << length, 2 << length), 1000):
            proc = subprocess.Popen([exec_path, a, b],
                                     stdout=subprocess.PIPE,
                                     stderr=subprocess.PIPE)
            start = time.time()
            out, err = proc.communicate()
            timings[length - 1] += time.time() - start
            if err:
                sys.exit("critical\n{}".format(err))
            if out.decode().strip().lower() == expected:
                passes += 1
            else:
                fails += 1
                sys.exit("\nfailed on input {!r}, {!r} ({})".format(a, b, out))
            print(
        "\rtesting {:13}, length {:3}-{:3}, passes {:5}, fails {:5}".format(
                script, 1 << length, 2 << length, passes, fails).ljust(80, " "),
                  end="")
    return "\n{0}\n{3:13} passed {1:.2%} in {2}\n{0}".format(
                        "*" * 80, passes / (passes + fails), " ".join("{:6.4f}".format(t) for t in timings),
                        script)

def main():
    args = get_args()
    pos_results = []
    neg_results = []
    for script in args.files:
        pos_results.append(test_correct(script, get_anagrams, "true"))
        neg_results.append(test_correct(script, get_nonanagrams, "false"))
    print("\npos:\n{}\nneg:\n{}".format("\n".join(pos_results),
                                      "\n".join(neg_results)))

if __name__ == "__main__":
    main()
