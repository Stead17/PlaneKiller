program SHoter;
uses
    crt, graph;
var
   x,y,r,graphdriver,graphmode: integer;
   s:char;
begin
initgraph(graphdriver,graphmode, '..BGI');
x:=getmaxX div 2;
y:=getmaxY div 2;
setbkcolor(15);
setcolor (9);
circle (x,y,10);
outtextXY(x-120,20,'Upravlenie - strelki, Enter - exit');
repeat
if keypressed then
 begin
  s:=readkey;
  case s of
  #72:begin
      setcolor(15);
      circle(x,y,10);
      if y>40 then y:=y-5;
      setcolor(9);
      circle (x,y,10);
      end;
  #75:begin
      setcolor(15);
      circle(x,y,10);
      if x>15 then x:=x-5;
      setcolor(9);
      circle (x,y,10);
      end;
   #77:begin
       setcolor(15);
       circle(x,y,10);
       if x<getmaxX-15 then x:=x+5;
       setcolor(9);
       circle (x,y,10);
       end;
   #80:begin
       setcolor(15);
       circle(x,y,10);
       if y<getmaxY-15 then y:=y+5;
       setcolor(9);
       circle (x,y,10);
       end;
   end;
 end;
until s=#13;
while keypressed do
      s:= readkey;
     closegraph;
end.