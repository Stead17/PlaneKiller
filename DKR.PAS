program the_game;
uses crt,graph,dos;
type
    TTime = record
      hours, minutes, seconds,hseconds: Word;
    end;

    Top10 = record
      name: string;
      progtime:longint;
    end;

var
 g,h:integer;
 rec:text;

  function ResTime(const STime, FTime: TTime): longint;
  begin
    ResTime := 36000 * Longint(FTime.hours) +
    6000 * longint(FTime.minutes) +
    100 * longint(FTime.seconds) +
    longint(FTime.hseconds) -
    36000 * longint(STime.hours) -
    6000 * longint(STime.minutes) -
    100 * longint(STime.seconds) -
    longint(STime.hseconds);
 end;

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
  const
   k=10000;
  var
   name: string;
   i:byte;
   number,buf:string;
   x1,x2,x3,y:word;
   time:longint;
   ch:char;
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
    for i:=1 to 10 do
    begin
      readln(rec,name);
      readln(rec,time);
      if time = k then time:=0;
      inc(y,30);
      str(i,number);
      OutTextXY(x1,y,number);
      OutTextXY(x2,y,name);
      str(time div 6000, number);
      buf:=number+' : ';
      str(time div 100, number);
      buf:=buf+number+' : ';
      str(time mod 100, number);
      buf:=buf+number;
      OutTextXY(x3,y,buf);
    end;
    close(rec);
    repeat
      ch:=readkey;
    until ch=#13 ;
  end;

  procedure sort_rec(ptime:longint; s:string);
  var
    A:array[0..10] of Top10;
    i,j,imin:byte;
    min:Top10;
  begin
    reset(rec);
    for i:= 0 to 9 do
    begin
      readln(rec,A[i].name);
      readln(rec,A[i].progtime);
    end;
    A[10].name:= s;
    A[10].progtime:= ptime;
    for j:=0 to 9 do
    begin
      min:=A[j];
      imin:=j;
      for i:=j+1 to 10 do
      begin
        if A[i].progtime < min.progtime then
        begin
           min:=A[i];
           imin:=i;
        end;
      end;
      A[imin]:=A[j];
      A[j]:=min;
    end;
    rewrite(rec);
    for i:= 0 to 9 do
    begin
      writeln(rec,A[i].name);
      writeln(rec,A[i].progtime);
    end;
    close(rec);
  end;

  procedure victory(base:real; x,y,x1,y1,r:integer; STime:TTime);
  var
    FinishTime:TTime;
    ch:char;
    time:longint;
    t,t1:string;
    k:word;
  begin
      with FinishTime do GetTime(Hours,Minutes,Seconds,HSeconds);
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
      time:=ResTime(STime,FinishTime);
      SetTextStyle(9,0,1);
      str(time div 6000,t);
      t1:=t+' : ';
      str(time div 100,t);
      t1:=t1+t+' : ';
      str(time mod 100,t);
      t1:=t1+t;
      OutTextXY(150,200,'Your time is');
      OutTextXY(350,200,t1);
      OutTextXY(50,250,'Enter your name : ');
      k:=320;
      SetTextStyle(10,0,1);
      t1:='';
      while (length(t1)<=5)and(ch<>#13) do
      begin
        ch:=readkey;
        if (ch in ['a'..'z','A'..'Z'])and(ch<>#77)and(ch<>#72)and(ch<>#75)and(ch<>#80) then
        begin
          t1:=t1+ch;
          OutTextXY(k,250,ch);
          inc(k,25);
        end;
      end;
      while ch<>#13 do ch:=readkey;
      sort_rec(time,t1);
 end;

  procedure move_cursor;
  var
    x,y,x1,y1,r,m,n: integer;
    ch:char;
    base:real;
    StartTime: TTime;
  begin
    ClearViewPort;
    randomize;
    x:=random(630);
    y:=random(470);
    repeat
      x1:=random(630);
      y1:=random(470);
      r:=random(60)+10;
    until (x1<>x) and (y1<>y);
    n:=294;
    m:=440;
    SetColor(10);
    OutTextXY(x,y,chr(16));
    base:=distance(x,y,x1,y1);
    repeat
      ch:=readkey;
    until (ch=#77)or(ch=#80)or(ch=#75)or(ch=#72)or(ch=#71);
    with StartTime do
     GetTime(Hours,Minutes,Seconds,HSeconds);
    while (ch<>#71)and (base > r) do
    begin
      ClearViewPort;
      case ch  of
        #77:begin
	      if x < 625 then inc(x,5);
	      OutTextXY(x,y,chr(16));
	      make_sound(base,m,n,x,y,x1,y1);

	    end;

	   #75:begin
	      if x>5 then dec(x,5);
	      OutTextXY(x,y,chr(17));
	      make_sound(base,m,n,x,y,x1,y1);
	    end;

	   #72:begin
	      if y>5 then dec(y,5);
	      OutTextXY(x,y,chr(30));
	      make_sound(base,m,n,x,y,x1,y1);
	     end;

	  #80:begin
	      if y<465 then inc(y,5);
	      OutTextXY(x,y,chr(31));
	      make_sound(base,m,n,x,y,x1,y1);

	    end;
      end;
      repeat
        ch:=readkey;
      until (ch=#77)or(ch=#72)or(ch=#75)or(ch=#80)or(ch=#71);

    end;
	victory(base,x,y,x1,y1,r,StartTime);
  end;

  procedure about;
  var
    ch:char;
  begin
    ClearViewPort;
    SetTextStyle(8,0,2);
    OutTextXY(50,50,'Try to find a hide area.');
    OutTextXY(50,70,'Move cursor and listen sound.');
    OutTextXY(50,90,'If sound hight then you move in a right way,');
    OutTextXY(50,110,'else you choose wrong way');
    while ch<>#13 do ch:=readkey;
  end;

  procedure main_menu;
  var
    ch:char;
    i:byte;
    k:word;
  begin
   while true do
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
      1 : about;
      2 : table_of_records;
      3 : Halt;
    end;
    ClearViewPort;
   end;
  end;



begin
  assign(rec,'records.txt');
  g:= detect;
  initgraph(g,h,'');
  main_menu;
  CloseGraph;
end.