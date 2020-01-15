with Ada.Text_IO, Ada.Numerics.Discrete_Random, Ada.Calendar,Ada.Calendar.Formatting, Ada.Containers.Vectors, Ada.Task_Identification;
use Ada.Text_IO,Ada.Calendar, Ada.Calendar.Formatting,Ada.Task_Identification;

package body alarms_pkg is


Sensor1 : Sensor(1);
Sensor2 : Sensor(2); 
Sensor3 : Sensor(3);
   
--Sensors : array (1 .. 5) of Sensor;

--package VectInt is new Ada.Containers.Vectors(Index_Type   => Natural, Element_Type => Sensor);	
	



task body Server is
begin
	Create (File => Output,Mode => Out_File,Name => "LOG_alarms.log");
	--Put_Line("Server active");
	Add_To_Log("server start");
	loop
		select 
			accept Received_Alarm(sensor_id: in Integer) do
				Put_Line("server: Received_Alarm from sensor: " & sensor_id'Img);
				Add_To_Log("server: Received_Alarm from sensor: " & sensor_id'Img);
			end Received_Alarm;
		or 
			accept Call_Police do
				Add_To_Log("Server: Call_Police");
			end Call_Police;
		or 
			accept Finito;
			Add_To_Log("Server: Finito");
			Close(Output);
			exit;
		or 
			delay 1.0;
		end select;
	end loop;
		
end Server;




task body Main_Thread is
	pass: Integer := 0;
begin
	delay 1.0;
	--Put_Line("main_thread active");
	Add_To_Log("Main_Thread start");
	loop 
		--Put("loop in main_thread ");
		select 
			accept Turn_On_Alarm do
				Add_To_Log("Main_Thread: Turn_On_Alarm");
				Turn_On_Sensors;
			end Turn_On_Alarm;
				
		or				-- only for comman line
			accept Validate_Pass do 
				Add_To_Log("Main_Thread: Validate_Pass");
			end Validate_Pass;
			GUI.Validate_Pass;	
		or
			accept Turn_Off_Alarm do
				Add_To_Log("Main_Thread: Turn_Off_Alarm");  
               Turn_Off_Sensors;
               Sensor1_alarm := True;
                  Sensor2_alarm := True;
                  Sensor3_alarm := True;
  			end Turn_Off_Alarm;
		or
			accept Receive_Alarm(sensor_id: Integer) do
				Add_To_Log("Main_Thread: Receive_Alarm from sensor " & sensor_cnt'Img); 
                                Server.Received_Alarm(sensor_id);
               case sensor_id is
                  when 1 => Sensor1_alarm := True;
                  when 2 => Sensor2_alarm := True;
                  when 3 => Sensor3_alarm := True;
                     when others => null;
                     end case;
                        end Receive_Alarm;
		or 
			accept Call_Police do 
				Add_To_Log("Main_Thread: Call_Police"); 
            		end Call_Police;
            		Put_Line("Calling for help . . .");
			Server.Call_Police;
		or 
			accept Set_Password do
				Add_To_Log("Main_Thread: Set_Password");
			end Set_Password;
            		GUI.Set_Pass;
            	--or
            	--	accept Add_Sensor do -- TODO kontrola czy juz nie ma maxa
              	--	Put_Line("Main_Thrad: Add_sensor");
               	--	Add_To_Log("Main_Thread: Add_sensor, sensor_cnt=" & sensor_cnt'Img); 
               	--	sensor_cnt := sensor_cnt + 1;
            	--	Sensors(sensor_cnt).Add(sensor_cnt);  --poza do?       		
               	--	end Add_Sensor;
		or 
			accept Finito;
			put_Line("Main_thread: Finito start");
			Sensor1.Finito;
			put_Line("Main_thread: Finito sensor1");
			Sensor2.Finito;
		        put_Line("Main_thread: Finito sensor2");
          		Sensor3.Finito;
         		put_Line("Main_thread: Finito sensor3");  
			--put_Line("Main_thread: Finito sensors");            
            		--for I in Sensors'Range loop
        		--	--if Sensors(I).id_sensor /= -1 then 
         		--	Sensors(I).Finito;
       			--	--end if;
        		--end loop; 
			GUI.Finito;
			put_Line("Main_thread: Finito text gui");
			RandomAlarmActivation.Finito;
			put_Line("Main_thread: Finito random activation");
			Server.Finito;	
			put_Line("Main_thread: Finito end");
			exit;
		--or 
		--	terminate;		
		end select;
	end loop;
end Main_Thread;


task body Sensor is 
      sensor_id: Integer := id; -- -1 dopoki nie dodamy sensora 
begin 
	delay 1.0;
	Put_Line("Sensor task:" & sensor_id'Img & " start");
	
	loop
                select
              	--	accept Add(id: in Integer) do
               	--		sensor_id := id;
                --        	Add_To_Log("Sensor: " & sensor_id'Img & " Added");
                --		end Add;
                --or
			accept Start do
				Add_To_Log("Sensor: " & sensor_id'Img & " Start");
			end Start;
			
		or
			accept Stop do
				Add_To_Log("Sensor: " & sensor_id'Img & " Stop");
			end Stop;
		or 
			accept Activated do
				Add_To_Log("Sensor: " & sensor_id'Img & " Activated");
				Main_Thread.Receive_Alarm(sensor_id);
			end Activated; 
		or 
			accept Finito;
			Add_To_Log("Sensor: " & sensor_id'Img & "Finito");
			exit;
		or
			delay 3.0; 
		end select;
	end loop;
exception
	when others => Put_Line("Exception in Sensor number: " & sensor_id'Img);
			Add_To_Log("Exception in Sensor number: " & sensor_id'Img);
end Sensor;


task body RandomAlarmActivation is
	package Random_Int is new Ada.Numerics.Discrete_Random(Rand_Range);
	use Random_Int;

	Val : Integer := 5;
	Gen: Generator; -- z pakietu Los_Znak
begin
	delay 1.0;
	Add_To_Log("RandomAlarmActivation start");
	loop
		--Put_Line("loop     is_alarm_active" & is_alarm_active'Img);
		select
			accept Finito do
				Add_To_Log("RandomAlarmActivation: Finito");
			end Finito;
			exit;
		else
			if is_dbg_active then--is_alarm_active then
			
			--select
			--	when is_alarm_active =>
			--		accept Start;
					--loop
					Reset(Gen);
					Val := Random(Gen);
					Put_Line("Alarm will be activated in " & Val'Img & "s");
					Add_To_Log("RandomAlarmActivation: Alarm will be activated in " & Val'Img & "s");
               				delay Duration(Val);--5.0;
               				--TODO aktywowac ajakas kontrolke
					Add_To_Log("        is_alarm_active:" & is_alarm_active'Img); 
               				if is_alarm_active then 
                 			 	Sensor1.Activated; 
                                                Sensor1_alarm := True;
              				end if;    	--Sensors(1)
					--end loop;	
			else 
				delay 1.0;
			end if;
		end select;
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
	Put_Line("9 - Exit");
	--Put_Line("ESC - Exit");
end Print_Menu;

task body GUI is
	--Zn: Character := ' ';
	is_pass_correct : Boolean := False;
begin
	
	delay 1.5;
	Put_Line("gui active");
	Add_To_Log("GUI start");
	--Print_Menu;
	loop 	
		select 
			accept Set_Pass do --;
				Add_To_Log("GUI: Set_Pass");
				Set_Password_from_user;
			end Set_Pass;	
		or
			accept Validate_Pass do --;
				Add_To_Log("GUI: Validate_Pass");
				is_pass_correct := Validate_Password_from_user("0000");
			end Validate_Pass;
			if is_pass_correct then
				Main_Thread.Turn_Off_Alarm;	
			else 
				Main_Thread.Receive_Alarm(0);
			end if;
		or 
                        accept Finito do
               			Put_Line("finito from gui");
                                Add_To_Log("GUI: Finito");
			end Finito;
                        exit;
		or	
            		delay 1.0;
            		--Command_Line_GUI;
		
		end select;
	end loop;
end GUI;

   
procedure Command_Line_GUI is
    	Zn: Character := ' ';
begin
     	--Put_Line("stuck in GUI");
	Get_Immediate(Zn);
	Add_To_Log("GUI: Get_Immediate(Zn):" & Zn);
	--exit when Zn = ASCII.ESC;
	case Zn is
      		when '1' => Put_Line("Turning on alarm . . ."); Main_Thread.Turn_On_Alarm;
         	when '2' => Put_Line("Turning off alarm . . ."); Main_Thread.Validate_pass;
		when '3' => Put_Line("Adding sensor . . .");
		when '4' => Put_Line("Calling police . . ."); Main_Thread.Call_Police;
		when '5' => Put_Line("Setting password . . ."); Main_Thread.Set_Password;
		when '9' => Put_Line("Exitinig . . ."); Main_Thread.Finito;--Abort_Task (Current_Task);
  		when others => Put_Line("Blad!!");
	end case; 
end Command_Line_GUI;
   
procedure Turn_On_Sensors is
begin
	Add_To_Log("Turn_On_Sensors");
	Sensor1.Start;
      	Sensor2.Start;
        Sensor3.Start;
     	--for I in Sensors'Range loop
        --	--if Sensors(I).id_sensor /= -1 then 
        -- 		Sensors(I).Start;
       	--	--end if;
        --end loop; 
      	--if sensor_cnt /= 0 then
        is_alarm_active := True;
        --end if; 
end Turn_On_Sensors;

procedure Turn_Off_Sensors is
begin
      	Add_To_Log("Turn_Off_Sensors");
      	--for I in Sensors'Range loop
        --	--if Sensors(I).id_sensor /= -1 then 
        --		Sensors(I).Stop;
       	--	--end if;
        --end loop; 
      
      
	Sensor1.Stop;
        Sensor2.Stop;
        Sensor3.Stop;
      	is_alarm_active := False;
        Put_Line("Sensors Turned off");
end Turn_Off_Sensors;

procedure Set_Password_from_user is
	pass: String(1..4) := "0000"; 
begin
	Add_To_Log("Set_Password_from_user: is_alarm_active - " & is_alarm_active'Img);
	if is_alarm_active then 
		Put_Line("Alarm is on! Can't change password!");
	else
		Put_Line("Enter old password:");
		pass := Get_Line;
		Add_To_Log("Set_Password_from_user: old password entered - " & pass);
		while pass /= password loop
			Put_Line("Password incorect! Try again.");
			Add_To_Log("Set_Password_from_user: old password entered - " & pass);
			pass := Get_Line;
		end loop;
		Put_Line("Enter new password:");
		pass := Get_Line;
		password := pass;
		Add_To_Log("Set_Password_from_user: new password entered - " & pass);
		Put_Line("Password set!");
	end if;
end Set_Password_from_user;


function Validate_password_from_user (tmp : String) return Boolean is
	pass: String(1..4) := "0000";  
	is_pass_correct : Boolean := False;
   begin 
        pass := tmp;
	Add_To_Log("Validate_password_from_user");
	Put_Line("Enter Password");
	for I in Integer range 1 .. 3 loop
		pass := Get_Line;
		Add_To_Log("Validate_password_from_user: password entered - " & pass);
		if pass = password then Put_Line("Alarm turded off"); return True; end if;
		Put_Line("Password incorrect!");
	end loop;
	return False;
	
end Validate_password_from_user;

procedure Add_To_Log(line: string) is
  T: Time;
begin
	T := Clock;
	Put(Output,Image(T) & ": ");
	Put_Line(Output,line);		 	
end Add_To_Log;


end alarms_pkg;
