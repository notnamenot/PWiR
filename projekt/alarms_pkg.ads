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
	entry Receive_Alarm(sensor_id: Integer);
	entry Call_Police;
end Main_Thread;

task RandomAlarmActivation;

task GUI;

procedure Print_Menu;

procedure Turn_On_Alarm;

procedure Turn_Off_Alarm;

end alarms_pkg;
