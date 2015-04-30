program Game;
uses crt, graph, FLIGHT;

var
   flightArr: array[1..10] of TFlight;
   g,h,e: integer;

procedure ClearAll(count : Integer);
    var i : Integer;
begin
    for i := 1 to count do
        flightArr[i].Clear;
end;

procedure Run;
    var exitCondition: Boolean;
        i: Integer;
begin
    exitCondition := false;
    while not exitCondition do
    begin
        for i := 1 to 3 do
            flightArr[i].Update;

        while keypressed do
        begin
            readkey;
            exitCondition := true;
        end;
        ClearAll(3);
    end;
end;

begin
     g:= detect;
     initgraph(g,h,'');
     if e <> grOk then
WriteLn(GraphErrorMsg(e))
else
begin
    setbkcolor(9);
    setcolor(1);                { THe ground}
    setfillstyle(1,2);
    fillellipse(319,478,150,60);

    flightArr[1].Init(20, 20);
    flightArr[2].Init(40, 80);
    flightArr[3].Init(10, 200);
    Run;
end;

     readln;
end.