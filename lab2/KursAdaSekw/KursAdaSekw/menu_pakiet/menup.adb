-- menup.adb

with Ada.Text_IO, Opcje, Ada.Calendar,Ada.Calendar.Formatting;
use Ada.Text_IO, Opcje, Ada.Calendar,Ada.Calendar.Formatting;

procedure MenuP is
	Zn: Character := ' '; 
	Output : File_Type;


procedure Pisz_Menu is
begin
	New_Line;  
	Put_Line("Menu:");  
	Put_Line(" s - opcja s");
	Put_Line(" c - opcja c");
	Put_Line(" p - opcja p");
	Put_Line("ESC -Wyjscie");
	Put_Line("Wybierz (s,c,p, ESC-koniec):");
end Pisz_Menu;
  
procedure Add_To_Log(line: string) is
  T: Time;
begin
	T := Clock;
	Put(Output,Image(T) & ": ");
	Put_Line(Output,line);		 	
end Add_To_Log;

begin
	Create (File => Output,Mode => Out_File,Name => "LOG_menup.txt");
	Add_To_Log("BEGIN MenuP");
  	loop
		Pisz_Menu;
		Get_Immediate(Zn);
		exit when Zn = ASCII.ESC;
		case Zn is
		  when 's' => Opcja_S; Add_To_Log("Opcja_S");
		  when 'c' => Opcja_C; Add_To_Log("Opcja_C");
		  when 'p' => Opcja_P; Add_To_Log("Opcja_P");
		  when others => Put_Line("Blad!!"); Add_To_Log("Nieobslugiwany Zank");
		end case;
	end loop;
	Put_Line("Koniec");
	Add_To_Log("END MenuP");
  	Close(Output);	
end MenuP;
  	 
  
