program relOpp
type
  ana := record begin
    intestinos:char;
    corazon, rinon:integer;
  end;
end;
var
a, b, c, d, e: integer;
f, g : Boolean;
an:ana;
function comparacion(x, y:integer):Boolean
begin
    if(x <= 30) then
      if(x >= y) then 
        {mientras y sea menor o igual que x, sumar 1 a y}
        while (y <= x) do
          y := y + 1;
      else
        while (x <= x) do
        begin
          x := x + 1;
          c := an.corazon;
          write('while multilinea');
        end;
    else
      write('x es muy grande: ', x);
end;
{
⠀⠀⠀⣠⣾⣿⣿⣿⣷⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⣿⣿⣿⣿⣷⣄⠀
}

begin
  a := 10;
  b := 20;
  c := 40;
  d := 30;
  f := true;

  IF(comparacion(a, b) AND 2 = a) then
  begin
    write('Entro');
    repeat begin
      f :=  (c > d);
      c := c + 1;
      d := d - 1;
      end;
    until ( 2 + 3 > a + 2 or true)
  end;

end;
