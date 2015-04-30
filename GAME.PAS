program Game;
uses crt, graph, FLIGHT;
const
     r = 3;

var
   flightObj: TFlight;
   x,x1,y,y1,g,h,e: integer;
   xmax,ymax,xmin,ymin : integer; { The limit of movings }
   Xstart_koord,Ystart_koord : integer; { Start koortinate position }
   Xstart_koord1,Ystart_koord1 : integer; { Start koordinate position }
   width,height : integer;
   width1,height1: integer;
   shift: word; { On what distance plane will move}
procedure Draw_Left_Side(var img : Pointer);
const
     fluger: array[1..4] of Pointtype = (  (x:40*r; y: r*5),
                                           (x:44*r; y: r),
                                           (x: 48*r; y: r),
                                           (x :48*r ; y:r*5 ) );
     wind: array[1..4] of Pointtype = ( ( x: 31*r; y: r*10 ),
                                      ( x: 38*r; y: 17*r ),
                                      ( x: 43*r; y: 17*r ),
                                      ( x: 38*r; y: r*10 ) );
var
    lx,ly,rx,ry,size : integer;
    fl : Boolean;
begin
    setfillstyle(1,4);             {The body of the plane }
    setlinestyle(0,0,1);
    rectangle(18*r,r*5,r*48,r*10);
    floodfill(r*20,r*6,1);


    { The fluger for left side }
    drawpoly( sizeof(fluger) div sizeof(Pointtype), fluger);
    floodfill(r*46,r*2,1);

    {The wind for left side}
    drawpoly( sizeof(wind) div sizeof(Pointtype), wind);
    floodfill(r*36,r*13,1);

    line(18*r,r*5,r*10,r*10);   { The nose for left side }
    line(r*10,r*10,r*18,r*10);
    floodfill(r*13,r*9,1);

    setlinestyle(0,0,1);      { The emblem left side }
    circle(46*r,3*r,r*2);
    setfillstyle(5,white);
    floodfill(46*r,3*r,1);


    setlinestyle(0,0,3);       { The window for left side  }
    line(18*r,5*r,18*r,r*9);
    line(18*r,r*9,12*r,r*9);
    line(18*r,r*9,26*r,r*5);
    setfillstyle(1,3);
    floodfill(17*r,r*8,1);
    floodfill(19*r,r*7,1);

    lx:= r*10 - r; { Taking picture }
    ly:= r-2;
    rx:= r*48 + r;
    ry:= r*17 + r;
    width1:= rx - lx + 1;
    height1:= ry - ly + 1;
    size:= imagesize(lx,ly,rx,ry);

    GetMem(img,size);
    GetImage(lx,ly,rx,ry,img^);
    PutImage(lx,ly,img^,xorPut);
    
end;
procedure Draw_Right_Side(var img : Pointer);
const
     fluger1: array [1..4] of Pointtype = ( (x:26*r; y:r*5),
                                             (x:22*r; y:r),
                                             (x:18*r; y:r),
                                             (x:18*r; y:r*5) );
     wind1: array [1..4] of Pointtype = ( (x: 38*r; y: r*10),
                                           (x: 31*r; y: r*17),
                                           (x: 26*r; y: r*17),
                                           (x: 31*r; y: r*10) );
var
    lx,ly,rx,ry,size : integer;

begin
    setfillstyle(1,4);             {The body of the plane }
    setlinestyle(0,0,1);
    rectangle(18*r,r*5,r*48,r*10);
    floodfill(r*20,r*6,1);

    { The fluger for right side }
    drawpoly( sizeof(fluger1) div sizeof(Pointtype), fluger1);
    floodfill(r*20,r*2,1);

    {The wind for righr side }
    drawpoly( sizeof(wind1) div sizeof(Pointtype), wind1);
    floodfill(r*32,r*13,1);

    line(48*r,r*5,r*56,r*10);   { The nose for right side }
    line(r*56,r*10,r*48,r*10);
    floodfill(r*52,r*9,1);

    setlinestyle(0,0,1);      { The emblem for right side }
    circle(20*r,3*r,r*2);
    setfillstyle(5,white);
    floodfill(20*r,3*r,1);

    setlinestyle(0,0,3);      { The window for right side }
    line(48*r,5*r,48*r,r*9);
    line(48*r,r*9,54*r,r*9);
    line(48*r,r*9,40*r,r*5);
    setfillstyle(1,3);
    floodfill(47*r,r*8,1);
    floodfill(49 * r, r * 7, 1);


    lx:= r*18 - r; { Taking picture }
    ly:= r-2;
    rx:= r*56 + r;
    ry:= r*17 + r;
    width:= rx - lx + 1;
    height:= ry - ly + 1;

    size:= imagesize(lx,ly,rx,ry);
    GetMem(img,size);
    GetImage(lx,ly,rx,ry,img^);
    PutImage(lx,ly,img^,xorput);

end;

procedure Moving(var x: Integer; var y: Integer);
    var delayInterval: Integer;
        movingRight, exitCondition: Boolean;
        image: Pointer;
begin
    delayInterval := 50;
    
    Xstart_koord := 40;
    Ystart_koord := 50;
    Xstart_koord1 := 400;
    Ystart_koord1 := 200;

    x := Xstart_koord;
    y := Ystart_koord;
    movingRight := true;
    exitCondition := false;
    shift := 20;

    Draw_Right_Side(image);
    while not exitCondition do
    begin
        if movingRight then
        begin
            if x + width < xmax then
            begin
                PutImage(x,y,image^,xorPut);
                delay( delayInterval);
                PutImage(x,y,image^,xorPut);
                x:= x + shift;
            end
            else
            begin
                movingRight := false;
                Draw_Left_Side(image);    
            end;
        end
        else
        begin
            if x >= xmin then
            begin
                PutImage(x,y,image^,xorPut);
                delay(delayInterval);
                PutImage(x,y,image^,xorPut);
                x := x - shift;
            end
            else
            begin
                movingRight := true;
                Draw_Right_Side(image);
            end;
        end;

        while keypressed do
        begin
            readkey;
            exitCondition := true;
        end;
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

    xmax:= getmaxX;
    ymax:= getmaxY;

    flightObj.Init(20, 20);
    flightObj.Moving;
end;

     readln;
end.