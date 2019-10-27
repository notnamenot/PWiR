with Ada.Text_IO, Ada.Numerics.Float_Random, Ada.Calendar, lab2_pkg;
use Ada.Text_IO, Ada.Numerics.Float_Random, Ada.Calendar, lab2_pkg;

-- procedura główna - dowolna nazwa
procedure Lab2 is
	
	MyWektor : Wektor(1..5);
	MyWektorLos : Wektor(1..5);

	T1, T2: Time; 	--czasy bezwzględne;
	D: Duration;	--czas względny
	

 begin
	T1 := Clock;	--odczytaanie aktualnego czasu
	MyWektor := (1..2=>3.0, 4=>2.0, others => 0.0);
	Losf(MyWektorLos);
	Print_Wektor(MyWektor);
	if not Check_Sort(MyWektor) then Sort_Wektor(MyWektor); Check_Sort(MyWektor); Print_Wektor(MyWektor); end if;
	Print_Wektor(MyWektorLos);
	if not Check_Sort(MyWektorLos) then Sort_Wektor(MyWektorLos); Check_Sort(MyWektorLos); Print_Wektor(MyWektorLos); end if;
	
	T2 := Clock;
	D := T2- T1;
	Put_Line("Czas wykonania programu = " & D'Img & "[s]"); -- atrybut 'Img

	Put_File;
end Lab2;
