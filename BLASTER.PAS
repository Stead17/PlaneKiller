unit BLASTER;

interface
uses
	crt,graph;

type
  TShoot = object
  public
    procedure Move(var x1, y1: Integer;  var OutCondition : Boolean);
    procedure Init;
    procedure BulletDraw;
    procedure Shooting;
    function Crossing(cornX, cornY, BulletX, BulletY, PlaneWidth, PlaneHeigth : Integer; var GtStr: Boolean): Boolean;
  private
    xmin, xmax: Integer;
    delayinterval: Integer;
    BlastShift : Integer;
    GetStart : Boolean;
    procedure BlastDraw;
    procedure MoveBlast(var x1, y1: Integer);
end;
var 
  CircX, CircY : Integer;
  button, button1: Char;
  Pict, ImgBullet : Pointer;
  x1, y1: Integer;
  flag : Boolean;
implementation

procedure TShoot.Init;
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
  flag:= true;
  button1:= '2';
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
procedure TShoot.Shooting;
begin
  {repeat}
  if GetStart = true then 
  begin
    CircX:= x1 + 4;
    CircY:= y1 + 6;
    PutImage(CircX, CircY, ImgBullet^, NormalPut);
    GetStart:= false;
  end;
  if CircY <= 0 then 
  begin
    delay(delayinterval);
    PutImage(CircX, CircY, ImgBullet^, NormalPut);
    CircY:= CircY - 5;
    PutImage(CircX, CircY, ImgBullet^, NormalPut);
  end
  else 
    GetStart:= false;
  {until (CircY <= 0);}
  {PutImage(CircX, CircY, ImgBullet^, XorPut);}
end;
procedure TShoot.Move(var x1, y1: Integer; var OutCondition : Boolean);
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
      if (BulletX + 6 = i) and (BulletY = j) then
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
    height:= ry - rx + 1;

    size:= ImageSize(lx, ly, rx, ry);
    GetMem(Pict, size);
    GetImage(lx,ly, rx, ry, Pict^);
    PutImage(lx, ly, Pict^, XorPut);
end;

end.