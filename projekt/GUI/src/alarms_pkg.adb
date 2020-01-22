with Ada.Text_IO, Ada.Numerics.Discrete_Random, Ada.Calendar,Ada.Calendar.Formatting, Ada.Containers.Vectors, Ada.Task_Identification;
use Ada.Text_IO,Ada.Calendar, Ada.Calendar.Formatting,Ada.Task_Identification;


package body alarms_pkg is
--  
--     procedure Free_Sensor is 
--     begin
--        Put_Line("Free_sensor");
--     end;
--     
   
   task body Sensor_Task_Type is   --TODO przy inicjalizacji l_sensor_id jest zapisywany, nie trzeba parametryzowac wejsc
   l_sensor_id : Integer := 0;    
   begin
      l_sensor_id := sensor_id;
      Put_Line("sensor task id: " & l_sensor_id'Img);
      loop 
         select 
            --accept Start;
            accept Activate do -- czujnik cos wykryl
               Put_Line("sensor task id in activate : " & l_sensor_id'Img);
               alarms_states(l_sensor_id) := True;
            end Activate;
            Main_Thread.Receive_Alarm(l_sensor_id);
         or
            accept Stop do
               Put_Line("sensor task id in stop : " & l_sensor_id'Img);
               Add_To_Log("Sensor: Stop");	
            end Stop;           
            exit;
         or
            delay 1.0;
         end select;
      end loop;
   exception
      when others => Put_Line("Exception in Sensor number: " & l_sensor_id'Img);
         Add_To_Log("Exception in Sensor number: " & l_sensor_id'Img);
   end Sensor_Task_Type;
   
   

   task body Server is
   begin
      Create (File => Output,Mode => Out_File,Name => "LOG_alarms.log");
      Add_To_Log("server start");
      Put_Line("server start");
      
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
            accept Stop;
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
      Add_To_Log("Main_Thread start");
      loop 
         select 
            accept Receive_Alarm(sensor_id: Integer) do
               Add_To_Log("Main_Thread: Receive_Alarm from sensor " & sensor_id'Img); 
               if sensor_id = 0 then Put_Line("Wrong password entered to many times"); end if;
               Server.Received_Alarm(sensor_id);
            end Receive_Alarm;
            
         or 
            accept Call_Police do 
               Add_To_Log("Main_Thread: Call_Police"); 
               Server.Call_Police;
            end Call_Police;	
            
         or 
            accept Turn_Sensors_On do
               is_alarm_active := True;
               for I in sensors_states'Range loop
                  if sensors_states(I) = True and sensors(I) = null then  --sprawdzic czy wynullowane 
                     Put_Line("sensor" & I'Img & "turned on");
                     sensors(I) := new Sensor_Task_Type(I);
                  end if;
               end loop;
            end Turn_Sensors_On;
            
         or 
            accept Turn_Sensors_Off;
            is_alarm_active := False;
            for I in sensors_states'Range loop
               if sensors_states(I) = False and sensors(I) /= null then
                  Put_Line("sensor" & I'Img & "turned off");
                  Free_Sensor(sensors(I));
               end if;
            end loop;
            
         or 
            accept Stop;
            Random_Alarm_Activation.Stop;
            put_Line("Main_thread: Stop random activation");
            Server.Stop;	
            put_Line("Main_thread: Stop server");
            Stop_Sensor_Tasks;
            put_Line("Main_thread: Stop sensors");
            exit;
            
         end select;
      end loop;
   end Main_Thread;
   
   
--     task body Sensor is 
--        sensor_id: Integer := id; -- -1 dopoki nie dodamy sensora 
--     begin 
--        delay 1.0;
--        Put_Line("Sensor task:" & sensor_id'Img & " start");
--        
--        loop
--           select
--              --	accept Add(id: in Integer) do
--              --		sensor_id := id;
--              --        	Add_To_Log("Sensor: " & sensor_id'Img & " Added");
--              --		end Add;
--              --or
--              accept Start do
--                 Add_To_Log("Sensor: " & sensor_id'Img & " Start");
--              end Start;
--              
--           or
--              accept Stop do
--                 Add_To_Log("Sensor: " & sensor_id'Img & " Stop");
--              end Stop;
--           or 
--              accept Activated do
--                 Add_To_Log("Sensor: " & sensor_id'Img & " Activated");
--                 Main_Thread.Receive_Alarm(sensor_id);
--              end Activated; 
--           or 
--              accept Finito;
--              Add_To_Log("Sensor: " & sensor_id'Img & "Finito");
--              exit;
--           or
--              delay 3.0; 
--           end select;
--        end loop;
--     exception
--        when others => Put_Line("Exception in Sensor number: " & sensor_id'Img);
--           Add_To_Log("Exception in Sensor number: " & sensor_id'Img);
--     end Sensor;
   
   
   task body Random_Alarm_Activation is --TODO task dzialajacy tylko jeslt dbg jest wlaczony
--        package Random_Delay is new Ada.Numerics.Discrete_Random(Random_Delay_Range);
--        use Random_Delay;
      package Random_Sensor_Id is new Ada.Numerics.Discrete_Random(Index_range);
      use Random_Sensor_Id;

      Sensor_To_Activate : Integer := 0;
      Time_To_Alarm_Activation : Integer := 2;
      --Random_Delay_Generator: Generator; 
      Random_Sensor_Generator : Generator;
      
   begin
      delay 1.0;
      Add_To_Log("Random_Alarm_Activation start");
      loop
         select
            accept Stop do
               Add_To_Log("Random_Alarm_Activation: Stop");
            end Stop;
            exit;
         
         or 
            accept Start_draw do
               Add_To_Log("Random_Alarm_Activation: Start_draw; is_alarm_active" & is_alarm_active'Img);
            end Start_draw;
   
            if not is_alarm_active then 
               Put_Line("Przed debugiem wlacz alarm!!");
            else
               Put_Line("random");
               for I in Index_range loop Put(sensors_states(I)'Img & " "); end loop;
               Reset(Random_Sensor_Generator);
               delay Duration(Time_To_Alarm_Activation);
               
               loop
                  Sensor_To_Activate := Random(Random_Sensor_Generator);
                  Put_Line(Sensor_To_Activate'Img);
                  
                  exit when sensors_states(Sensor_To_Activate) = True;
               end loop;   
               sensors(Sensor_To_Activate).Activate;
            end if;  
         or 
            delay 1.0;
            
         end select;
      end loop;
   end Random_Alarm_Activation;
   

   procedure Stop_Sensor_Tasks is 
   begin
      for I in sensors'Range loop
         if sensors(I) /= null then
            Free_Sensor(sensors(I));
         end if;
      end loop;
   end Stop_Sensor_Tasks;
   
   
   procedure Add_To_Log(line: string) is
      T: Time;
   begin
      T := Clock;
      Put(Output,Image(T) & ": ");
      Put_Line(Output,line);		 	
   end Add_To_Log;
   
   procedure Turn_Alarm_Off is
   begin
      for I in Index_range loop
            alarms_states(I) := false;
         end loop;
   end Turn_Alarm_Off;
   
end alarms_pkg;
