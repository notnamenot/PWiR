with Ada.Text_IO, Ada.Numerics.Discrete_Random, alarms_pkg,Ada.Task_Identification;
use Ada.Text_IO, alarms_pkg,Ada.Task_Identification;


procedure main is 
--	Zn: Character := ' ';
begin
	--null;
	delay 0.5;
	Put_Line("main");
	
	Add_To_Log("main start");

	--null;
--	delay 0.5;
--	Print_Menu;
--	loop 	
--		Get_Immediate(Zn);
--		exit when Zn = ASCII.ESC;
--		case Zn is
--	 		when '1' => Put_Line("Alarm turned on"); Turn_On_Alarm;
--			when '2' => Put_Line("Alarm turned off"); Turn_Off_Alarm;
--			when '4' => Put_Line("Calling police"); Main_Thread.Call_Police;
--	  		when others => Put_Line("Blad!!");
--		end case;
--	end loop;
	--if True then
	--	Put_Line("main");
	--	Abort_Task (Current_Task);
  	-- end if;
	--Put_Line("End main");
	--Add_To_Log("END main");
  	--Close(Output);	
end main;
