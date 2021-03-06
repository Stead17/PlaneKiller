program Game;
uses crt, graph, FLIGHT, BLASTER; { Including sime modules }
const 
    StartBlX = 315; { Start coordinates of  a blaster }
    StartBlY = 357;
var
   flightArr: TFlight; { Oblect plane, which declared in module FLIGHT }
   Blast : TShoot; { Object blaster, which declared in module BLASTER }
   g, h, e : integer; { Some variables to detect graph mode }
   StartPlX, StartPlY : Integer; { Start coordinates of a plane }
   LooseLine : Integer; 

procedure Descriptions; { The section in menu Rules }
var
    ch:char;
begin
    ClearViewPort;
    SetTextStyle(7, 0, 1);
    OutTextXY(10, 70, 'Try to bring down a plane');
    OutTextXY(10, 90, 'Move you blaster with keybuttons');
    OutTextXY(10, 110, 'Shoot at plane with button space');
    OutTextXY(10, 130, 'You have only one bullet to shoot');
    OutTextXY(10, 150, 'Also you have three levels of hardness');
    OutTextXY(10, 170, 'The easiest level means you have the bigest plane');
    OutTextXY(10, 190, 'The hardest level means you have the smallest plane');
    OutTextXY(10, 210, 'You can press slash " / " to call emergency call');
    OutTextXY(10, 230, 'You can use escape to get back to previous menu');
    OutTextXY(10, 250, 'Good Luck!!! :)');
    SetTextStyle(0, 0, 1);
    while ch<>#27 do ch:=readkey;
end;

procedure BackGround; 
begin
    LooseLine:= 355;
    setbkcolor(LightBlue);
    setcolor(Blue);
    setfillstyle(1, 2);
    fillellipse(319, 478, 150, 60);
    SetLineStyle(1, 1, 3);
    Line(0, LooseLine, 679, LooseLine );
end;

procedure ClearAll; { Taking out from the screnn a plane }
var 
    i: Integer;
begin
        if ImgRight = nil then 
        flightArr.Clear(ImgLeft)
        else 
        flightArr.Clear(ImgRight);
end;

procedure Run; { Procedure which do every proccess of movings }
    var exitCondition: Boolean; 
        GetStart: Boolean;
        i, j: Integer;
begin
    exitCondition:= false;
    GetStart:= false;
    while not exitCondition do
    begin
       flightArr.Update;

        if keypressed then
        begin
            button:= readkey;
            if (button = #77) or (button = #75) or (button = #47) or (button = #32) then
            Blast.Move(x1, y1, exitCondition, GetStart);
        end;

        if GetStart = true then
            Blast.MoveBullet(CircX, CircY, exitCondition, GetStart);

        if y + height <= LooseLine  then
            ClearAll
        else
        begin
            exitCondition:= true;
            SetTextStyle(9, 0, 2);
            OutTextXY(270, 200, 'YOU LOOSE! :(');
            SetTextStyle(0, 0, 1);
        end;

        if exitCondition and (GetStart = false) then 
        begin
            OutTextXY(CircX, CircY - 10, 'BOOOMM!!!');
        end;    
    end;
    delay(1500); { Delay to see the dissapear of a plane }
end;
procedure Start(koef : integer); { The initial procedure }
begin
    SetActivePage(0);
    SetVisualPage(0);
    SetTextStyle(0, 0, 1);
    SetLineStyle(0, 0 ,1);
    BackGround;
    randomize;
    StartPlX:= random(600);
    StartPlY:= random(200);
    flightArr.Init(StartPlX, StartPlY, koef);
    Blast.Init(StartBlX, StartBlY);
    Run;  
end;
function LevelChoose : Integer; forward; 
  procedure main_menu; 
  var
    ch:char;
    i:byte;
    k:word;
    Hardness : integer;
  begin
  SetActivePage(2);
  SetVisualPage(2);
   while true do
   begin
    i:=0;
    SetColor(Red);
    SetBkColor(Cyan);
    SetTextStyle(10,0,4);
    OutTextXY(150,100,'PLANE KILLER');
    SetTextStyle(9,0,1);
    OutTextXY(270,150,'play');
    OutTextXY(270,190,'rules');
    OutTextXY(270,230,'exit');
    circle(250,170,3);
    k:=170;
    SetTextStyle(0,0,1);
    ch:=readkey;
    while ch<>#13 do
    begin
      case ch of
    #72:begin
              if i<> 0 then
              begin
                SetColor(Cyan);
                circle(250,k,3);
                dec(k,40);
                SetColor(Red);
                circle(250,k,3);
                dec(i);
              end
              else
                begin
                  SetColor(Cyan);
                  circle(250,k,3);
                  k:=250;
                  SetColor(Red);
                  circle(250,k,3);
                  i:=2;
                end;
         end;

    #80:begin
              if i<>2 then
              begin
                SetColor(Cyan);
                circle(250,k,3);
                inc(k,40);
                SetColor(Red);
                circle(250,k,3);
                inc(i);
              end
              else
                begin
                  SetColor(Cyan);
                  circle(250,k,3);
                  k:=170;
                  SetColor(Red);
                  circle(250,k,3);
                  i:=0;
                end;
        end;
      end;
      ch:=readkey;
    end;

    case i of
      0 :
      begin
          ClearViewPort;
          Hardness:= LevelChoose;
          ClearViewPort;
          Start(Hardness);
       end; 
      1 : Descriptions;
      2 : Halt;
    end;
    Cleardevice;
   end;
  end;

function LevelChoose : Integer; 
var 
    ch: Char;
    k, Cursor : integer;
begin
    ClearViewPort;
    Cursor:= 1;
    SetTextStyle(8, 0, 2);
    OutTextXY(100, 250, 'Easy');
    OutTextXY(300, 250, 'Middle');
    OutTextXY(500, 250, 'Hard');
    circle(90, 262, 3);
    k:= 90;

    while ch <> #13 do
    begin
        case ch of
        #75:
        begin
            if Cursor = 1 then
            begin
                Cursor:= 3;
                SetColor(Cyan);
                circle(k, 262, 3);
                k:= 490;
                SetColor(Red);
                circle(k, 262, 3);
            end
            else
            begin
                dec(Cursor);
                SetColor(Cyan);
                circle(k,262,3);
                dec(k,200);
                SetColor(Red);
                circle(k,262,3);
            end;
        end;
        #77:
        begin
            if Cursor = 3 then 
            begin
              Cursor:= 1;
              SetColor(Cyan); 
              circle(k, 262, 3);
              k:= 90;
              SetColor(Red);
              circle(k, 262, 3); 
            end
            else
            begin
                inc(Cursor);
                SetColor(Cyan);
                circle(k, 262, 3);
                inc(k,200);
                SetColor(Red);
                circle(k, 262, 3);
            end;
        end;
        #27:
        begin
        ClearViewPort;
        main_menu;
        end;
        end;
    ch:= readkey;
    end;
    LevelChoose:= Cursor;
end;


begin
     g:= detect;
     initgraph(g,h,'');
     if e <> grOk then
WriteLn(GraphErrorMsg(e))
else
begin
    main_menu;
end;
end.