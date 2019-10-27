with Ada.Text_IO, Ada.Numerics.Float_Random;
use Ada.Text_IO, Ada.Numerics.Float_Random;

package body lab2_pkg is 

procedure Print_Wektor(W: Wektor) is
begin
	for I in W'Range loop
		Put_Line("W(" & I'Img & ")=" & W(I)'Img);
	end loop;
	New_Line;
end Print_Wektor;

procedure Losf(W: in out Wektor) is
  Wart : Float := 0.0; 
  Gen: Generator; -- z pakietu Ada.Numerics.Float_Random 
begin
  Reset(Gen);
  for I in W'Range loop
	Wart := Random(Gen);
	W(I) := Wart;
  end loop;
end Losf;    

function Check_Sort(W: Wektor) return Boolean is
	(for all I in W'First..(W'Last-1) => W(I) <= W(I+1));
	
procedure Check_Sort(W: Wektor) is
Flaga : Boolean; 
begin
	Flaga := (for all I in W'First..(W'Last-1) => W(I) <= W(I+1));
	if Flaga = True then Put_Line("Tablica posortowana rosnąco"& LF & CR);
	else Put_Line("Tablica nie posortowana rosnąco" & LF & CR); 
	end if;
end Check_Sort;

procedure Sort_Wektor(W: in out Wektor) is 
sorted: Boolean := false;
tmp: Float;
begin
	while not sorted loop
		sorted := true;
		for I in W'First..(W'Last-1) loop
			if W(I) > W(I+1) then 
				sorted := false;
				tmp := W(I);
				W(I) := W(I+1);
				W(I+1) := tmp;
			end if;
		end loop;
	end loop;
end Sort_Wektor;

procedure Put_File is --(name: string) is
File: File_Type;
Nazwa: string(1..100) := (others => ' ');
Dlugosc: integer := 0;
begin
  loop
	Put_Line("Podaj nazwę pliku do otwarcia: ");
	Get_Line(Nazwa, Dlugosc);
   	begin
		Open(File => File, Mode => In_File, Name => Nazwa(1..Dlugosc));
		exit;
	exception
		when Name_Error => Put_Line("Bledna nazwa pliku < " & Nazwa(1..Dlugosc) & " > !");
 	end;
  end loop;

	while not End_Of_File(File) loop
		Put_Line(Get_Line(File));
	end loop;
	
	Close(File);
end Put_File;


end lab2_pkg;




