program the_game;
uses crt,graph;
var
 g,h:integer;
 rec:text;

  function distance(x,y,x1,y1:real):real;
  var
    a:real;
  begin
    a:=sqrt(sqr(x-x1)+sqr(y-y1));
    distance:=a;
  end;

  procedure make_sound(var base:real;var m,n:integer; x,y,x1,y1:real);
  var
    temp:real;
  begin
    temp:=distance(x,y,x1,y1);
    if temp < base then
      begin
        sound(m);
        if m < 600 then inc(m,1);
      end
    else
      begin
        sound(n);
        if n > 10 then dec(n,1);
      end;
    base:=temp;
  end;

  procedure table_of_records;
  var
   name,time: string;
   i:byte;
   x1,x2,x3,y:word;
  begin
    ClearViewPort;
    reset(rec);
    x1:=30;
    x2:=100;
    x3:=400;
    y:=30;
    SetTextStyle(8,0,2);
    OutTextXY(x2,y,'Name');
    OutTextXY(x3,y,'Time');

    for i:= 1 to 10 do
    begin
      readln(rec,name);
      readln(rec,time);
      inc(y,30);
      OutTextXY(x1,y,'1');
      OutTextXY(x2,y,name);
      OutTextXY(x3,y,time);
    end;
    close(rec);
    readkey;
  end;

  procedure victory(base:real; x,y,x1,y1,r:integer);
  var
    ch:char;
  begin
    if base<r then
    begin
      NoSound;
      OutTextXY(x,y,chr(2));
      SetColor(Yellow);
      Circle(x1,y1,r);
      while keypressed do ch:=readkey;
      Delay(700);
      ClearViewPort;
      SetColor(Green);
      SetTextStyle(10,0,4);
      OutTextXY(150,50,'Congratulation');
      OutTextXY(180,100,'You Win !!!');
    end;
  end;

  procedure move_cursor;
  var
    x,y,x1,y1,r,m,n: integer;
    ch:char;
    base:real;
  begin
    ClearViewPort;
    randomize;
    x:=random(630);
    y:=random(470);
    repeat
      x1:=random(630);
      y1:=random(470);
      r:=random(50)+5;
    until (x1<>x) and (y1<>y);
    n:=294;
    m:=440;
    SetColor(10);
    OutTextXY(x,y,chr(16));
    base:=distance(x,y,x1,y1);
    repeat
      ch:=readkey;
    until (ch=#77)or(ch=#80)or(ch=#75)or(ch=#72)or(ch=#71);

    while ch<>#71 do
    begin
      ClearViewPort;
      case ch  of
        #77:begin
	      if x<625 then inc(x,5);
	      OutTextXY(x,y,chr(16));
	      make_sound(base,m,n,x,y,x1,y1);
	      victory(base,x,y,x1,y1,r);
	    end;

	#75:begin
	      if x>5 then dec(x,5);
	      OutTextXY(x,y,chr(17));
	      make_sound(base,m,n,x,y,x1,y1);
	      victory(base,x,y,x1,y1,r);
	    end;

	#72:begin
	      if y>5 then dec(y,5);
	      OutTextXY(x,y,chr(30));
	      make_sound(base,m,n,x,y,x1,y1);
	      victory(base,x,y,x1,y1,r);
	     end;

	#80:begin
	      if y<465 then inc(y,5);
	      OutTextXY(x,y,chr(31));
	      make_sound(base,m,n,x,y,x1,y1);
	      victory(base,x,y,x1,y1,r);
	    end;
      end;
      repeat
        ch:=readkey;
      until (ch=#77)or(ch=#72)or(ch=#75)or(ch=#80)or(ch=#71);

    end;
    NoSound;
    Halt;
  end;


  procedure main_menu;
  var
    ch:char;
    i:byte;
    k:word;
  begin
    i:=0;
    SetColor(10);
    SetTextStyle(10,0,4);
    OutTextXY(170,50,'THE GAME');
    SetTextStyle(9,0,1);
    OutTextXY(270,150,'play');
    OutTextXY(270,190,'rules');
    OutTextXY(270,230,'records');
    OutTextXY(270,270,'exit');
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
                SetColor(16);
		circle(250,k,3);
                dec(k,40);
                SetColor(10);
                circle(250,k,3);
                dec(i);
              end
              else
                begin
                  SetColor(16);
		  circle(250,k,3);
                  k:=290;
                  SetColor(10);
                  circle(250,k,3);
                  i:=3;
                end;
	     end;

	#80:begin
              if i<>3 then
              begin
                SetColor(16);
		circle(250,k,3);
                inc(k,40);
                SetColor(10);
                circle(250,k,3);
                inc(i);
              end
              else
                begin
                  SetColor(16);
		  circle(250,k,3);
                  k:=170;
                  SetColor(10);
                  circle(250,k,3);
                  i:=0;
                end;
	    end;
      end;
      ch:=readkey;
    end;

    case i of
      0 : move_cursor;
      1 : Halt;
      2 : table_of_records;
      3 : Halt;
    end;
  end;



begin
  assign(rec,'records.txt');
  g:= detect;
  initgraph(g,h,'');
  main_menu;
  {move_cursor; }
  CloseGraph;
end.