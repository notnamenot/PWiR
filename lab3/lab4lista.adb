with Ada.Text_IO, Ada.Integer_Text_IO, Ada.Numerics.Discrete_Random;
use Ada.Text_IO, Ada.Integer_Text_IO;

procedure Lab4Lista is

subtype Rand_Range is Integer range 0..99;

type Element is
  record 
    Data : Integer := 0;
    Next : access Element := Null;
  end record; 

type Elem_Ptr is access all Element;

procedure Print(List : access Element) is
  L : access Element := List;
begin
  if List = Null then
    Put_Line("List EMPTY!");
  else
    Put_Line("List:"); 
  end if; 
  while L /= Null loop
    Put(L.Data, 3); -- z pakietu Ada.Integer_Text_IO
    L := L.Next;
  end loop; 
  New_Line;
end Print;

procedure Insert(List : in out Elem_Ptr; D : in Integer) is
  E : Elem_Ptr := new Element; 
begin
  E.Data := D;
  E.Next := List;
  -- lub E.all := (D, List);
  List := E;
end Insert;

-- wstawianie jako funkcja - wersja krótka
function Insert(List : access Element; D : in Integer) return access Element is 
  ( new Element'(D,List) ); 

-- do napisania !! 
-- napisz procedurę wstawiającą element zachowując posortowanie (rosnące) listy
procedure Insert_Sort(List : in out Elem_Ptr; D : in Integer) is 
	E : Elem_Ptr := new Element; 
	L : access Element := List;
	L_prev : access Element := L;
	found_place_to_insert : Boolean := false;  
begin
  E.Data := D;
	if L = Null then List := E;	
	elsif D <= L.Data then E.Next := List; List:= E;
	else 		
		L_prev := L;
		L := L.Next;
		while L /= Null loop
			if D <= L.Data then
				E.Next := L;
				L_prev.Next := E;
				found_place_to_insert := true;
				Exit;
			end if;
			L_prev := L;
			L := L.Next;
		end loop;
		if not found_place_to_insert then L_prev.Next := E; end if;
	end if;
end Insert_Sort;

procedure Generate_And_Insert(List: in out Elem_Ptr; n: integer) is
	package Rand_Int is new Ada.Numerics.Discrete_Random(Rand_Range);
    use Rand_Int;
	
	Wart: integer := 0;
	Gen: Generator;
begin
	Reset(Gen);
	for i in 0..n loop
		Wart := Random(Gen);
		Insert_Sort(List, Wart);
	end loop;
end Generate_And_Insert;


function Is_Elem_In_List(List: in out Elem_Ptr; data: integer) return Boolean is
	result : boolean := false;
	L: access Element := List;
begin
	while L /= null loop
		if L.Data = data then result := true; exit; end if;
	L := L.Next;
	end loop;
	return result;
end Is_Elem_In_List;

procedure Check_if_Elem_In_List(List: in out Elem_Ptr; data: integer) is
begin
	if Is_Elem_In_List(List,data) then 
		Put_Line(data'IMG & " is on list"); 
	else 
		Put_Line(data'IMG & " is not on list"); 
	end if;
end Check_if_Elem_In_List;

procedure Delete_From_List(List: in out Elem_Ptr; data: integer) is
	L: access Element := List;
	L_prev: access Element := L;
begin
	if L = null then null;
	elsif L.Next = null and L.Data = data then L.Data := 0; 
	else 
		while L /= null loop
			if L.Data = data then
				L_prev.Next := L.Next;
				Exit;
			end if;
			L_prev := L;
			L := L.Next;
		end loop;
	end if;
end Delete_From_List;

Lista : Elem_Ptr := Null;

begin
	Print(Lista);
	Lista := Insert(Lista, 21);
	Print(Lista);
	Insert(Lista, 20); 
	Print(Lista);
	for I in reverse 1..8 loop
	Insert(Lista, I);
	end loop;
	Print(Lista);
	Insert_Sort(Lista, 7);
	Insert_Sort(Lista, 40);
	Insert_Sort(Lista, 0);
	Insert_Sort(Lista, 13);
	Print(Lista);
	Generate_And_Insert(Lista,5);
    Print(Lista);
	Check_if_Elem_In_List(Lista,40);
	Check_if_Elem_In_List(Lista,50);
	Delete_From_List(Lista,0);
	Delete_From_List(Lista,7);
	Delete_From_List(Lista,20);
	Print(Lista);
end Lab4Lista;
