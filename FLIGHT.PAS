unit FLIGHT;

interface
uses
	crt, graph;

const
	xmin = 0;
	ymin = 0;
	r = 2;
var 
	x, y: Integer;
	width: Integer;
	height: Integer;
	ImgLeft, ImgRight: Pointer;			
type
TFlight = object { The define of an object Plane }
	public
		procedure Init(_x: Integer; _y: Integer; factor : integer);
		procedure Update; { Draw of it on differnt positions }
		procedure Clear(image : Pointer); 
	private
		xmax, ymax: Integer;
		movingRight: Boolean;
		size, size1 : Integer;
	   	shift, shift1 : word; { On what distance plane will move}
	   	delayInterval: Integer;

		procedure GetLeftSideImage;
		procedure GetRightSideImage;
		procedure Draw(image : Pointer); { Craetinf an image of a plane and getting it into the memory }
end;

implementation

procedure TFlight.Init(_x: Integer; _y: Integer; factor : integer);
begin
	x := _x; { Start сoordinates }
	y := _y; { Start сoordinates }
	xmax := getMaxX;
	ymax := getMaxY;
    delayInterval := 70;
    New(ImgLeft);
    New(ImgRight);
    ImgLeft:= nil;
    ImgRight:= nil;
    movingRight := true;
    case factor of 
    1:
    begin
    	shift:= 40;
    	shift1:= 20;
    end;
    2: 
    begin
    	shift:= 80;
    	shift1:= 40; 
    end;
    3:
    begin
    	shift:= 80;
    	shift1:= 60;
    end;
    
    end;
    TFlight.GetRightSideImage;
end;

procedure TFlight.Draw(image : Pointer);
begin
	SetActivePage(0);
	SetVisualPage(0);
 	PutImage(x, y, image^, XorPut);
    delay (delayInterval);
end;

procedure TFlight.Clear(image: Pointer );
begin
	PutImage(x, y, image^, xorPut);
end;

procedure TFlight.Update;
begin
	if (x + width <= xmax) and ( movingRight ) then
	begin
		if ImgRight = nil then 
			TFlight.GetRightSideImage;
		x := x + shift;
		TFlight.Draw(ImgRight);
		if x + width > xmax then 
		begin
			movingRight:= false;	
			FreeMem(ImgRight, size);
			ImgRight:= nil;
			y:= y + shift1;
		end;
	end
	else
	begin
		if (x >= xmin) and ( movingRight = false ) then 
		begin 
			if ImgLeft = nil then 
				TFlight.GetLeftSideImage;
			x:= x - shift;
			TFlight.Draw(ImgLeft);
			if x < xmin then 
			begin
				movingRight:= true;
				FreeMem(ImgLeft, size1);
				ImgLeft:= nil;
				y:= y + shift1;
			end;
		end;	
	end;
end;

procedure TFlight.GetRightSideImage;
const
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
var
	lx, ly, rx, ry : integer;
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

    lx:= r * RectangleParameters[1]; { Taking picture }
    ly:= r * Flug1;
    rx:= r * Nose1;
    ry:= r * Wind3;

    width:= rx - lx;
    height:= ry - ly;
    size:= imagesize(lx, ly, rx, ry);

    GetMem(ImgRight, size);
    GetImage(lx, ly, rx, ry, ImgRight^);
    PutImage(lx, ly, ImgRight^, XorPut);

end;

procedure TFlight.GetLeftSideImage;
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
		lx, ly, rx, ry : integer;
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

    size1:= imagesize(lx, ly, rx, ry);
    GetMem(ImgLeft, size1);
    GetImage(lx, ly, rx, ry, ImgLeft^);
	PutImage(lx, ly,ImgLeft^, XorPut);
end;

end.