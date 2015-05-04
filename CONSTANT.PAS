program Constant;
uses crt;
const
	FLugerParameters: array [1..7] of Integer = (45, 15, 5, 40, 35, 40, 10);
var
	x,i: Integer;
begin  clrscr;
 	write('FLugerParameters { ');
	for i:= 1 to 7 do
	write(FLugerParameters[i]:2,', ');
	writeln(' }');

    writeln(FlugerParameters[1]);
    x:= FlugerParameters[2];
    writeln(x);
	readln;
end.