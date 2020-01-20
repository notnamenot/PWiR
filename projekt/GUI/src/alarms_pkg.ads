with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Strings; use Ada.Strings;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Unchecked_Deallocation;

package alarms_pkg is
   
   pragma Elaborate_Body(alarms_pkg); --to ensure proper initialization

   subtype Index is Integer range 1 .. 10;
   subtype Random_Delay_Range is Integer range 3 .. 5;
   
   Output : File_Type;
      
   is_dbg_active: Boolean := False;
   
   is_alarm_active: Boolean := False;
   
   sensors_states: array (Index) of Boolean := (others => False);  --tablica mowiaca o tym czy dany czujnik ma byc wlaczony
   
   alarms_states:  array (Index) of Boolean := (others => False); --tablica mowiaca o tym czy i ktory alarm(czujnik) zostal aktywowany
   
   task type Sensor_Task_Type(sensor_id: Integer) is
      entry Activate(sensor_id: in Integer);
      entry Stop(sensor_id: in Integer);
   end Sensor_Task_Type;
      
   type Sensor_Task_Type_Ptr is access all Sensor_Task_Type;
   
   procedure Free_Sensor is new Ada.Unchecked_Deallocation(Object => Sensor_Task_Type, Name => Sensor_Task_Type_Ptr);
   
   Sensors : array(Index) of Sensor_Task_Type_Ptr;
   
   task Server is
      entry Received_Alarm(sensor_id: in Integer);
      entry Call_Police;
      entry Stop;
   end Server;

   task Main_Thread is 
      entry Turn_Sensors_On;
      entry Turn_Sensors_Off;
      entry Receive_Alarm(sensor_id: Integer);
      entry Call_Police;
      entry Stop;
   end Main_Thread;
   
   task Random_Alarm_Activation is
      entry Stop;
   end Random_Alarm_Activation;

   procedure Stop_Sensor_Tasks;
   
   procedure Add_To_Log(line: string);

end alarms_pkg;
