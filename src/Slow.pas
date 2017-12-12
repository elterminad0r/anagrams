program Slow;

uses
    SysUtils;

function is_anagram(a, b: string): boolean;
var
    available: array of boolean;
    i: integer;
    c: char;
    found_match: boolean;
begin
    if length(a) <> length(b) then
        exit(False)
    else
        setLength(available, length(b));
        for i := 0 to length(b) - 1 do
            available[i] := True;
        for c in a do begin
            found_match := False;
            for i := 0 to length(b) - 1 do
                if  (not found_match)
                     and available[i]
                     and (b[i + 1] = c) then begin
                    available[i] := False;
                    found_match := True;
                end;
            if not found_match then
                exit(False);
        end;
    exit(True);
end;

begin
    writeln(is_anagram(ParamStr(1), ParamStr(2)));
end.
