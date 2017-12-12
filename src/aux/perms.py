import itertools
import sys

def letters(text):
    return "".join(filter(str.isalpha, text))

def is_anagram(a, b):
    return tuple(letters(a)) in itertools.permutations(b)

if __name__ == "__main__":
    print(is_anagram(*sys.argv[1:]))
