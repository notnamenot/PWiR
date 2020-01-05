package alarms_pkg is

subtype Rand_Range is Integer range 5 .. 10;

task type Sensor(id: Integer) is		-- Number to wyroznik - parametr typu zadaniowego 
	entry Start;
	entry Stop;
	entry Activated; 
end Sensor;

task Server is
	entry Received_Alarm(sensor_id: in Integer);
	entry CallPolice;
end Server;

task Main_Thread is 
	entry Turn_On_Alarm;
	entry Turn_Off_Alarm;
	entry Receive_Alarm(sensor_id: Integer);
	entry Call_Police;
	entry Set_Password;
end Main_Thread;

task RandomAlarmActivation;

task GUI;

procedure Print_Menu;

procedure Turn_On_Sensors;

procedure Turn_Off_Sensors;

--function Set_Password_from_user return Integer;

procedure Set_Password_from_user;

function Validate_password_from_user return Boolean;

end alarms_pkg;
