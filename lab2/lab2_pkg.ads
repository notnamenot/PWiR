package lab2_pkg is

type Wektor is array (Integer range <>) of Float;

CR : constant Character := Character'Val (13);--carridge return
LF : constant Character := Character'Val (10);--line feed

procedure Print_Wektor(W: Wektor);
procedure Losf(W: in out Wektor);
function Check_Sort(W: Wektor) return Boolean;
procedure Check_Sort(W: Wektor);
procedure Sort_Wektor(W: in out Wektor);

procedure Put_File;--(name: string);

end lab2_pkg;
