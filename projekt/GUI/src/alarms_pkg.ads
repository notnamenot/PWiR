with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Strings; use Ada.Strings;
with Ada.Text_IO; use Ada.Text_IO;

package alarms_pkg is

Output : File_Type;
password: String(1..4) := "0000";
Sensor1_alarm: Boolean := False;  
Sensor2_alarm: Boolean := False;  
Sensor3_alarm: Boolean := False;  

subtype Rand_Range is Integer range 5 .. 10;

task type Sensor(id: Integer) is		-- Number to wyroznik - parametr typu zadaniowego 
        --entry Add(id: in Integer); 
	entry Start;
	entry Stop;
	entry Activated; 
	entry Finito;
end Sensor;

task Server is
	entry Received_Alarm(sensor_id: in Integer);
	entry Call_Police;
	entry Finito;
end Server;

task Main_Thread is 
      	--entry Add_Sensor;
	entry Turn_On_Alarm;
	entry Validate_Pass;
	entry Turn_Off_Alarm;
	entry Receive_Alarm(sensor_id: Integer);
	entry Call_Police;
	entry Set_Password;
	entry Finito;
end Main_Thread;

task RandomAlarmActivation is
	entry Finito;
end RandomAlarmActivation;

task GUI is
	entry Set_Pass;
	entry Validate_Pass;
	entry Finito;
end GUI;

procedure Print_Menu;
   
procedure Command_Line_GUI;

procedure Turn_On_Sensors;

procedure Turn_Off_Sensors;

--function Set_Password_from_user return Integer;

procedure Set_Password_from_user;

function Validate_password_from_user(tmp : String) return Boolean;

procedure Add_To_Log(line: string);

end alarms_pkg;
