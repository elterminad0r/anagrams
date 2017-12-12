program Primes;

uses
    SysUtils;

const
    prime_table: array['a'..'z'] of integer =
                           (5, 71, 37, 29, 2, 53, 59, 19, 11, 83, 79, 31, 43,
                            13, 7, 67, 97, 23, 17, 3, 41, 73, 47, 89, 61, 101);
    alpha: set of char = ['a'..'z','A'..'Z'];

function prime_hash(plain: string): integer;
var
    prod: integer = 1;
    c: char;
begin
    for c in plain do
        if c in alpha then
            prod := prod * prime_table[LowerCase(c)];
    prime_hash := prod;
end;

function is_anagram(a, b: string): boolean;
begin
    is_anagram := prime_hash(a) = prime_hash(b);
end;

begin
    writeln(is_anagram(ParamStr(1), ParamStr(2)));
end.
