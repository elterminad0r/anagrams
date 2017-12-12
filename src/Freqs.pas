program Freqs;

uses
    SysUtils;

const
    alphabet: set of char = ['a'..'z','A'..'Z'];

type
    LetterFrequency = array['a'..'z'] of integer;

function new_freq: LetterFrequency;
var
    freqs: LetterFrequency;
    i: char;
begin
    for i := 'a' to 'z' do
        freqs[i] := 0;
    new_freq := freqs;
end;

function compare_freqs(a, b: LetterFrequency): boolean;
var
    i: char;
begin
    for i := 'a' to 'z' do
        if a[i] <> b[i] then
            exit(False);
    exit(True);
end;

function get_freq(plain: string): LetterFrequency;
var
    freqs: LetterFrequency;
    i: integer;
begin
    freqs := new_freq;
    for i := 1 to length(plain) do
        if plain[i] in alphabet then
            inc(freqs[LowerCase(plain[i])]);
    get_freq := freqs;
end;

function is_anagram(a, b: string): boolean;
begin
    is_anagram := compare_freqs(get_freq(a), get_freq(b));
end;

begin
    writeln(is_anagram(ParamStr(1), ParamStr(2)));
end.
