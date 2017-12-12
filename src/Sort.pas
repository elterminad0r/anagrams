{$MODE OBJFPC}

program Sort;

uses SysUtils;

procedure swap_vars(var a, b: char);
var
    t: char;
begin
    t := b;
    b := a;
    a := t;
end;

procedure swap_vars(var a, b: integer);
var
    t: integer;
begin
    t := b;
    b := a;
    a := t;
end;

procedure find_minmax(plain: string; lower, upper: integer; out min, max: integer);
var
    i: integer;
begin
    min := lower;
    max := upper;
    if min > max then
        swap_vars(min, max);
    for i := lower to upper do
        if plain[i] < plain[min] then
            min := i
        else if plain[i] > plain[max] then
            max := i;
end;

procedure selection_sort(var plain: string);
var
    lower, upper, min, max: integer;
begin
    lower := 1;
    upper := length(plain);
    while upper > lower do begin
        find_minmax(plain, lower, upper, min, max);
        swap_vars(plain[max], plain[upper]);
        if min = upper then
            swap_vars(plain[max], plain[lower])
        else
            swap_vars(plain[min], plain[lower]);
        lower := lower + 1;
        upper := upper - 1;
    end;
end;

function is_anagram(a, b: string): boolean;
begin
    selection_sort(a);
    selection_sort(b);
    is_anagram := a = b;
end;

begin
    writeln(is_anagram(ParamStr(1), ParamStr(2)));
end.
