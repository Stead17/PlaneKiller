unit BLASTER;

interface
uses
	crt,graph, FLIGHT;

type
  TShoot = object
  public
    procedure Move(var x1, y1: Integer;  var OutCondition, GtStr : Boolean);
    procedure Init(_x, _y : Integer);
    procedure BulletDraw;
    procedure MoveBullet(var CircleX, CircleY : Integer; var ExCond, GtStr : Boolean);
  private
    xmin, xmax: Integer;
    delayinterval: Integer;
    BlastShift : Integer;
    GetStart : Boolean;
    procedure BlastDraw;
    procedure MoveBlast(var x1, y1: Integer);
    function Crossing(cornX, cornY, BulletX, BulletY, PlaneWidth, PlaneHeigth : Integer; var GtStr: Boolean): Boolean;
end;
var 
  CircX, CircY : Integer;
  button : Char;
  Pict, ImgBullet : Pointer;
  x1, y1: Integer;
  flag : Boolean;
implementation

procedure TShoot.Init(_x, _y : Integer);
begin
  TShoot.BlastDraw;
  TShoot.BulletDraw;
  SetVisualPage(0);
  SetActivePage(0);
  delayinterval:= 11;
  xmin:= 0;
  xmax:= 599;
  BlastShift:= 10;
  GetStart:= true;
  x1:= _x;
  y1:= _y;
  PutImage(x1, y1, Pict^, Normalput);
end;
procedure TShoot.Move(var x1, y1: Integer; var OutCondition, GtStr : Boolean);
begin
  case button of 
    #75 : 
    begin
      if x1 - BlastShift >= xmin then
      TShoot.MoveBlast(x1,y1);
    end;
    #77 :
    begin
      if x1 + BlastShift <= xmax then
      TShoot.MoveBlast(x1,y1);
    end;
    #47: 
      OutCondition:= true;
    #32:
    begin
      if GtStr = false then 
      begin
        CircX:= x1 + 4;
        CircY:= y1 + 6;
        PutImage(CircX, CircY, ImgBullet^, XorPut);
        GtStr:= true;
      end;
    end;
  end;
end;

procedure TShoot.MoveBlast(var x1, y1: Integer);
begin
  PutImage(x1, y1, Pict^, XorPut);
  if button = #75 then
    x1:= x1 - BlastShift
  else 
    x1:= x1 + BlastShift;
  delay(delayinterval);
  PutImage(x1, y1, Pict^, XorPut);   
end;

procedure TShoot.MoveBullet(var CircleX, CircleY : Integer; var ExCond, GtStr : Boolean);
var BoomCondition: Boolean;
    BulletShift: Integer;
begin
  BulletShift:= 15;
  PutImage(CircleX, CircleY, ImgBullet^, XorPut);
  CircleY:= CircleY - BulletShift;
  PutImage(CircleX, CircleY, ImgBullet^, XorPut);
  BoomCondition:= TShoot.Crossing(x, y, CircleX, CircleY, width, height, GtStr);
  if CircleY - BulletShift <= 0 then
  begin
    GtStr:= false;
    PutImage(CircleX, CircleY, ImgBullet^, Xorput);                
    OutTextXY(CircleX, CircleY, 'Was Close');
  end;
  if (GtStr = false) and (BoomCondition = false)  then
  begin
    ExCond:= true;
    PutImage(CircleX, CircleY, ImgBullet^, Xorput);
  end;
end;

function TShoot.Crossing(cornX, cornY, BulletX, BulletY, PlaneWidth, PlaneHeigth : Integer;var GtStr: Boolean): Boolean;
var 
  i, j: Integer;
begin
  for i:= cornX to cornX + PlaneWidth do
  begin
    for j:= cornY to cornY + PlaneHeigth do
    begin
      if ( (BulletX + 6 = i) or (BulletX = i) or (BulletX + 12 = i) ) and ( ( BulletY = j ) or (BulletY + 6 = j) ) then
      begin
        GtStr:= false;
        Crossing:= false;
        break;
      end;
    end;
  end;
end;

procedure TShoot.BulletDraw;
var 
  BulletRadius, lx, ly, rx ,ry, size, width, height: Integer;
begin
  SetActivePage(1);
  SetVisualPage(1);
  BulletRadius:= 6;
  SetLineStyle(0, 0, 1);
  Circle(300, 200, BulletRadius);
  SetFillStyle(1,DarkGray);
  FloodFill(300, 200, Blue);
  SetLineStyle(0, 0, 1);

  lx:= 293;
  ly:= 193;
  rx:= 307;
  ry:= 207;

  width:= rx - lx + 1;
  height:= ry - rx + 1;

  size:= ImageSize(lx, ly, rx, ry);
  GetMem(ImgBullet, size);
  GetImage(lx,ly, rx, ry, ImgBullet^);
  PutImage(lx, ly, ImgBullet^, XorPut);
end;
procedure TShoot.BlastDraw;
var 
  lx, ly, rx, ry, width, height, size: Integer;
begin
    SetActivePage(1);
    SetVisualPage(1);
    SetLineStyle(0,0,1);
	  Ellipse(300, 439, 180, 0, 10, 30);
  	Ellipse(300, 439, 0, 360, 10, 10);
  	SetFillStyle(1,Red);
   	FloodFill(300,438,1);
    FloodFill(300,457,1);

    lx:= 289;
    ly:= 409;
    rx:= 331;
    ry:= 469;

    width:= rx - lx + 1;
    height:= ry - ly + 1;

    size:= ImageSize(lx, ly, rx, ry);
    GetMem(Pict, size);
    GetImage(lx,ly, rx, ry, Pict^);
    PutImage(lx, ly, Pict^, XorPut);
end;

end.