with Ada.Text_IO, Ada.Numerics.Discrete_Random, Ada.Strings.Unbounded;
use Ada.Text_IO, Ada.Strings.Unbounded;

package body alarms_pkg is

is_alarm_active: Boolean := false;
password : Integer := 0;
Sensor1 : Sensor(1);
Sensor2 : Sensor(2); 
	



task body Server is
begin
	Put_Line("Server active");
	loop
		select 
			accept Received_Alarm(sensor_id: in Integer) do
				Put_Line("  server: alarm received from sensor: " & sensor_id'Img);
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
	pass: Integer := 0;
	is_pass_correct: Boolean := False;
begin

	loop 
		--Put("loop in main_thread ");
		select 
			accept Turn_On_Alarm do
				if password = 0 then Set_Password_from_user; end if;
				Turn_On_Sensors;
			end Turn_On_Alarm;
			Print_Menu;
		or
			accept Turn_Off_Alarm do 
				is_pass_correct := Validate_password_from_user;
				if is_pass_correct then	
					--Put_Line("Passwrd correct, turning off alarm.." & is_pass_correct'Img); 
					Turn_Off_Sensors;
				else 
					Server.Received_Alarm(0);
				end if;
			end Turn_Off_Alarm;
			Print_Menu;
		or
			accept Receive_Alarm(sensor_id: Integer) do
				--Put_Line("main thread: alarm received");
				Server.Received_Alarm(sensor_id);
			end Receive_Alarm;
		or 
			accept Call_Police;
				Server.CallPolice;
		or 
			accept Set_Password do
				Set_Password_from_user;					
			end Set_Password;
			Print_Menu;
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
   	if not is_alarm_active then Put_Line("1 - Turn on alarm");end if;
	if is_alarm_active then Put_Line("2 - Turn off alarm"); end if;
	--Put_Line("3 - Add sensor");
	Put_Line("4 - Call police");
	Put_Line("5 - Set password");
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
	 		when '1' => Put_Line("Turning on alarm . . ."); Main_Thread.Turn_On_Alarm;
			when '2' => Put_Line("Turning off alarm . . ."); Main_Thread.Turn_Off_Alarm;
			when '3' => Put_Line("Adding sensor . . .");
			when '4' => Put_Line("Calling police . . ."); Main_Thread.Call_Police;
			when '5' => Put_Line("Setting password . . ."); Main_Thread.Set_Password;
	  		when others => Put_Line("Blad!!");
		end case;
	end loop;
end GUI;

procedure Turn_On_Sensors is
begin
	Sensor1.Start;
	Sensor2.Start;
end Turn_On_Sensors;

procedure Turn_Off_Sensors is
begin
	Sensor1.Stop;
	Sensor2.Stop;
end Turn_Off_Sensors;

procedure Set_Password_from_user is
	pass: Integer := 0; 
begin
	if is_alarm_active then 
		Put_Line("Alarm is on! Can't change password!");
	elsif password = 0 then 	-- pierwsze ustawienie
		Put_Line("Enter new password:");
		pass := Integer'Value(Get_Line);
		password := pass;
		--Put_Line("new password: " & pass'Img);
		--return pass;
		Put_Line("Password set!");
	else
		Put_Line("Enter old password:");
		pass := Integer'Value(Get_Line);
		while pass /= password loop
			Put_Line("Password incorect! Try again.");
			pass := Integer'Value(Get_Line);
		end loop;
		Put_Line("Enter new password:");
		pass := Integer'Value(Get_Line);
		password := pass;
		--Put_Line("new password: " & pass'Img);
		--return pass;
		Put_Line("Password set!");
	end if;
	
	--Print_Menu;
end Set_Password_from_user;


function Validate_password_from_user return Boolean is
	pass: Integer := 0; 
begin 
	Put_Line("Enter Password");
	for I in Integer range 1 .. 3 loop
		pass := Integer'Value(Get_Line);
		if pass = password then return True; end if;
		Put_Line("Password incorrect!");
	end loop;
	return False;

end Validate_password_from_user;

end alarms_pkg;
