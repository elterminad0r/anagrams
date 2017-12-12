program RecSort;

function min(plain: string; a, b: integer): integer;
begin
    if plain[a] < plain[b] then
        min := a
    else
        min := b;
end;

function min_of_string(plain: string; i: integer): integer;
begin
    if i = length(plain) then
        min_of_string := i
    else
        min_of_string := min(plain, i, min_of_string(plain, i + 1));
end;

function swap_chars(plain: string; a, b: integer): string;
var
    t: char;
begin
    t := plain[a];
    plain[a] := plain[b];
    plain[b] := t;
    swap_chars := plain;
end;

function _selection_sort(plain: string; i: integer): string;
begin
    if length(plain) = i then
        _selection_sort := plain
    else
        _selection_sort := _selection_sort(
                             swap_chars(plain, i,
                                        min_of_string(plain, i)),
                             i + 1);
end;

function selection_sort(plain: string): string;
begin
    selection_sort := _selection_sort(plain, 1);
end;

function is_anagram(a, b: string): boolean;
begin
    is_anagram := selection_sort(a) = selection_sort(b);
end;

begin
    writeln(is_anagram(ParamStr(1), ParamStr(2)));
end.
