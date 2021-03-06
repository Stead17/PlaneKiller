unit PLANE;

interface
uses graph;
const
	r = 2;


procedure HideLeftDraw;
procedure HideRightDraw;

implementation

procedure HideLeftDraw;
const
	{ Rectangle consnstant Parameters }
	RectangleParameters: array[1..5] of Integer = (15,20,25,30,45);

	{ Fluger constant Parameters }
	Flug1 = 5;
	Flug2 = 10;
	Flug3 = 15;
	Flug4 = 35;
	Flug5 = 42;
	Flug6 = 45;

	{ Wind constant Parameters }
	Wind1 = 25;
	Wind2 = 30;
	Wind3 = 35;
	Wind4 = 38;
	Wind5 = 43;

	{ Nose constant Parameters }
	Nose1 = 5;
	Nose2 = 14;
	Nose3 = 20;

	{ Window constant Parameters }
	Window1 = 6;
	Window2 = 13;
	Window3 = 17;
	Window4 = 18;
	Window5 = 19;
	Window6 = 24;

	{ Emblem constant Parameters }
	Emblem1 = 42;
	Emblem2 = 3;

	Fluger: array[1..4] of Pointtype =( (x: r * Flug6; y: r * Flug3),
										(x: r * Flug6; y: r * Flug1),
										(x: r * Flug5; y: r * Flug1),
										(x: r * Flug4; y: r * Flug3) );

	Wind: array[1..4] of Pointtype = (  (x: r * Wind2; y: r * Wind1),
										(x: r * Wind4; y: r * Wind3),
										(x: r * Wind5; y: r * Wind3),
										(x: r * Wind4; y: r * Wind1) );
var
	lx,ly,rx,ry,size,width,height : integer;
	img : Pointer;
begin
	SetActivePage(1);
	SetLineStyle(0, 0, 1);

	{ The Body of the plane }
	Rectangle(r * RectangleParameters[1], r * RectangleParameters[1], r * RectangleParameters[5], r * RectangleParameters[3]);
	SetFillStyle(1,Red);
	FloodFill(r * RectangleParameters[4], r * RectangleParameters[2], Blue);

	{ The fluger }
	DrawPoly( sizeof(Fluger) div sizeof(Pointtype), Fluger);
  	SetFillStyle(1,Red);
	FloodFill(r * Flug5, r * Flug2, Blue);

	{ The wind }
	DrawPoly( sizeof(Wind) div sizeof(Pointtype), Wind);
  	SetFillStyle(1,Red);
	FloodFill(r * Wind4,r * Wind2,Blue);

	{ The nose }
	Line(r * RectangleParameters[1], r * RectangleParameters[1], r * Nose1, r * RectangleParameters[3]);
	Line(r * Nose1, r * RectangleParameters[3], r * RectangleParameters[1], r * RectangleParameters[3]);
  	SetFillStyle(1,Red);
	FloodFill(r * Nose2, r * Nose3, Blue);

	{ The emblem }
  	Circle(r * Emblem1, r * Flug2,r * Emblem2);
    SetFillStyle(6,Cyan);
    FloodFill(r * Flug5, r * Flug2,1);

    { The window }
    SetLineStyle(0, 0, 3);
    Line(r * RectangleParameters[1], r * RectangleParameters[1], r * RectangleParameters[1], r * Window6);
    Line(r * RectangleParameters[1], r * Window6, r * Window1, r * Window6);
    Line(r * RectangleParameters[1], r * Window6, r * RectangleParameters[3], r * RectangleParameters[1]);
    SetFillStyle(1, Cyan);
    FloodFill(r * Window2, r * Window5, 1);
    FloodFill(r * Window3, r * Window4, 1);

    lx:= r * Nose1;
    ly:= r * Flug1;
    rx:= r * RectangleParameters[5];
    ry:= r * Wind3;
    width:=  rx - ly + 1;
    height:= ry - ly + 1;

    size:= imagesize(lx, ly, rx, ry);
    GetMem(img, size);
    GetImage(lx, ly, rx, ry, img^);

    SetActivePage(0);
    PutImage(200, 200, img^, XorPut);

end;

procedure HideRightDraw;
const
	r = 2;
	{ Rectangle consnstant Parameters }
 	RectangleParameters: array[1..5] of Integer = (15,20,25,30,45);

	{ Fluger constant Parameters }
	Flug1 = 5;
	Flug2 = 10;
	Flug3 = 15;
	Flug5 = 18;
	Flug4 = 25;
	Flug6 = 45;

	{ Wind constant Parameters }
	Wind1 = 25;
	Wind2 = 30;
	Wind3 = 35;
	Wind4 = 22;
	Wind5 = 17;

	{ Nose constant Parameters }
	Nose1 = 55;
	Nose2 = 46;
	Nose3 = 20;

	{ Window constant Parameters }
	Window1 = 54;
	Window2 = 47;
	Window3 = 43;
	Window4 = 18;
	Window5 = 19;
	Window6 = 24;

	{ Emblem constant Parameters }
	Emblem1 = 18;
	Emblem2 = 3;

	Wind: array[1..4] of Pointtype = (  (x: r * Wind2; y: r * Wind1),
										(x: r * Wind4; y: r * Wind3),
										(x: r * Wind5; y: r * Wind3),
										(x: r * Wind4; y: r * Wind1) );

	Fluger: array[1..4] of Pointtype =( (x: r * Flug3; y: r * Flug3),
										(x: r * Flug3; y: r * Flug1),
										(x: r * Flug5; y: r * Flug1),
										(x: r * Flug4; y: r * Flug3) );
begin
	SetActivePage(0);
	SetLineStyle(0, 0, 1);

	{ The Body of the plane }
 	Rectangle(r * RectangleParameters[1], r * RectangleParameters[1], r * RectangleParameters[5], r * RectangleParameters[3]);
	SetFillStyle(1,Red);
	FloodFill(r * RectangleParameters[4], r * RectangleParameters[2], Blue);

	{ The fluger }
	DrawPoly( sizeof(Fluger) div sizeof(Pointtype), Fluger);
  	SetFillStyle(1,Red);
	FloodFill(r * Flug5, r * Flug2, Blue);

	{ The wind }
	DrawPoly( sizeof(Wind) div sizeof(Pointtype), Wind);
  	SetFillStyle(1,Red);
	FloodFill(r * Wind4,r * Wind2,Blue);

	{ The nose }
	Line(r * RectangleParameters[5], r * RectangleParameters[1], r * Nose1, r * RectangleParameters[3]);
	Line(r * Nose1, r * RectangleParameters[3], r * RectangleParameters[5], r * RectangleParameters[3]);
  	SetFillStyle(1,Red);
	FloodFill(r * Nose2, r * Nose3, Blue);

	{ The window }
    SetLineStyle(0, 0, 3);
    Line(r * RectangleParameters[5], r * RectangleParameters[1], r * RectangleParameters[5], r * Window6);
    Line(r * RectangleParameters[5], r * Window6, r * Window1, r * Window6);
    Line(r * RectangleParameters[5], r * Window6, r * ( RectangleParameters[3] + 10 ), r * RectangleParameters[1]);
    SetFillStyle(1, Cyan);
    FloodFill(r * Window2, r * Window5, 1);
    FloodFill(r * Window3, r * Window4, 1);

    { The emblem }
    SetLineStyle(0,0,1);
  	Circle(r * Emblem1, r * Flug2,r * Emblem2);
    SetFillStyle(6,Cyan);
    FloodFill(r * Flug5, r * Flug2,1);


end;
procedure AnotherPlane;
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
    lx,ly,rx,ry,size,width,height : integer;
    image : Pointer;

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

    size := imagesize(lx,ly,rx,ry);
    GetMem(image, size);
    GetImage(lx, ly, rx, ry, image^);

end;

end.
