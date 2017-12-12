# https://en.wikipedia.org/wiki/Letter_frequency
# grep "[^ ]" 

"""
Generate a suitable table of primes based on letter frequency
"""

import sympy

if __name__ == "__main__":
    letters = "etaoinshrdlcumwfgypbvkjxqz"
    tab = [(sympy.prime(ind), i) for ind, i in enumerate(letters, 1)]
    tab.sort(key=lambda x: x[1])
    print(tab)
    print("({})".format(", ".join(str(prime) for prime, _ in tab)))
