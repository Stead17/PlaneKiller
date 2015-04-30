unit FLIGHT;

interface
uses
	crt, graph;

const
     r = 3;
     xmin = 0;
     ymin = 0;

Type
TFlight = object
	public
		procedure Init(_x: Integer; _y: Integer);
		procedure Update;
		procedure Clear;
	private
		x, y, xmax, ymax: Integer;
		movingRight: Boolean;
		image: Pointer;
		width,width1: Integer;
		height, height1: Integer;
	   	shift: word; { On what distance plane will move}
	   	delayInterval: Integer;

		procedure GetLeftSideImage;
		procedure GetRightSideImage;
		procedure ClearXY(_x : Integer; _y : Integer);
		procedure Draw;
end;


implementation

	procedure TFlight.Init(_x: Integer; _y: Integer);
	begin
		x := _x; { Start сoordinates }
		y := _y; { Start сoordinates }
    	xmax := getMaxX;
    	ymax := getMaxY;
	    delayInterval := 50;

	    movingRight := true;
	    shift := 20;

	    TFlight.GetRightSideImage;
	    {TFlight.Draw;}
	end;

	procedure TFlight.GetLeftSideImage;
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

	    GetMem(image, size);
	    GetImage(lx,ly,rx,ry,image^);
	    ClearXY(lx, ly);
	    {PutImage(lx,ly,image^, orPut);}
	end;
	procedure TFlight.GetRightSideImage;
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

	    size := imagesize(lx,ly,rx,ry);
	    GetMem(image, size);
	    GetImage(lx, ly, rx, ry, image^);
	    ClearXY(lx, ly);
	    {PutImage(lx,ly,image^, orPut);}

	end;

	procedure TFlight.Draw;
	begin
        PutImage(x, y, image^, orPut);
        delay (delayInterval);
	end;

	procedure TFlight.Clear;
	begin
		PutImage(x, y, image^, xorPut);
	end;

	procedure TFlight.ClearXY(_x : Integer; _y : Integer);
	begin
		PutImage(_x, _y, image^, xorPut);
	end;

	procedure TFlight.Update;
	begin
        if movingRight then
        begin
            if x + width < xmax then
            begin
                x := x + shift;
            	TFlight.Draw;
            end
            else
            begin
                movingRight := false;
                TFlight.GetLeftSideImage;
            end;
        end
        else
        begin
            if x >= xmin then
            begin
                x := x - shift;
            	TFlight.Draw;
            end
            else
            begin
                movingRight := true;
                TFlight.GetRightSideImage;
            end;
        end;
	end;
end.