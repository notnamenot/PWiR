with Ada.Text_IO, Ada.Numerics.Discrete_Random;
use Ada.Text_IO;

package body alarms_pkg is

is_alarm_active: Boolean := false;
Sensor1 : Sensor(1);
Sensor2 : Sensor(2); 	



task body Server is
begin
	Put_Line("Server active");
	loop
		select 
			accept Received_Alarm(sensor_id: in Integer) do
				Put_Line("server: alarm received from sensor: " & sensor_id'Img);
			end Received_Alarm;
		or 
			accept CallPolice;
				Put_Line("Calling police . . .");
		or 
			delay 1.0;
		end select;
	end loop;
		
end Server;




task body Main_Thread is
begin

	loop 
		--Put("loop in main_thread ");
		select 
			accept Receive_Alarm(sensor_id: Integer) do
				Put_Line("main thread: alarm received");
				Server.Received_Alarm(sensor_id);
			end Receive_Alarm;
		or 
			accept Call_Police;
				Server.CallPolice;
--		else 			
		end select;

	end loop;
end Main_Thread;


task body Sensor is 
	sensor_id: Integer := id;
begin 
	--Put_Line("Sensor id: " & sensor_id'Img);
	loop
		select
			accept Start; --do
				is_alarm_active := true;
				--Put_Line("active: " & is_alarm_active'Img);
				--for I in 1..10 loop 
				--	Put("Start Sensor: " & sensor_id'Img);
				--end loop;
				--RandomAlarmActivation.Start;
				--exit;	
			--end Start;
		or
			accept Stop; --do
				is_alarm_active := false;
				--for I in 1..10 loop 
				--	Put("Finish Sensor: " & sensor_id'Img);
				--end loop;
				--exit;
			--end Finish;
		or 
			accept Activated do
				Main_Thread.Receive_Alarm(sensor_id);

			end Activated;
		or 
			delay 3.0; 
		end select;
	end loop;
exception
	when others => Put_Line("Exception in Sensor number: " & sensor_id'Img);
end Sensor;


task body RandomAlarmActivation is
	package Random_Int is new Ada.Numerics.Discrete_Random(Rand_Range);
	use Random_Int;

	Val : Integer := 5;
	Gen: Generator; -- z pakietu Los_Znak
begin
	--Put_Line("RandomAlarmActivation");
	loop
		--Put_Line("loop     is_alarm_active" & is_alarm_active'Img);
		if is_alarm_active then
		
		--select
		--	when is_alarm_active =>
		--		accept Start;
				--loop
				Reset(Gen);
				Val := Random(Gen);
				Put_Line("Alarm will be activated in " & Val'Img & "s");
				delay Duration(Val);--5.0;
				if is_alarm_active then Sensor1.Activated; end if;			
				--end loop;	
		else 
			delay 3.0;
		end if;
		--end select;
	end loop;
end RandomAlarmActivation;


procedure Print_Menu is
begin
	New_Line;  
	Put_Line("Menu:");  
   	Put_Line("1 - Turn on alarm");
	Put_Line("2 - Turn off alarm");
	Put_Line("4 - Call police");
	--Put_Line("ESC - Exit");
end Print_Menu;

task body GUI is
	Zn: Character := ' ';
begin
	delay 0.5;
	Print_Menu;
	loop 	
		Get_Immediate(Zn);
		exit when Zn = ASCII.ESC;
		case Zn is
	 		when '1' => Put_Line("Alarm turned on"); Turn_On_Alarm;
			when '2' => Put_Line("Alarm turned off"); Turn_Off_Alarm;
			when '4' => Put_Line("Calling police"); Main_Thread.Call_Police;
	  		when others => Put_Line("Blad!!");
		end case;
	end loop;
end GUI;

procedure Turn_On_Alarm is
begin
	Sensor1.Start;
	Sensor2.Start;
end Turn_On_Alarm;

procedure Turn_Off_Alarm is
begin
	Sensor1.Stop;
	Sensor2.Stop;
end Turn_Off_Alarm;

end alarms_pkg;
