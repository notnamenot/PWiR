with Ada.Text_IO; use Ada.Text_IO;
with alarms_pkg;  use alarms_pkg;
with Gtk.Enums;   use Gtk.Enums;
with Gtk.Main;

package body main_cb is
   procedure main_quit (Self : access Gtk_Widget_Record'Class) is
   begin
      Put_Line("main on destroy");
      Main_Thread.Stop;
      Gtk.Main.Main_Quit;
   end main_quit;
   
   
   -------------------------- Configuration ------------------------------------
   
   procedure Configuration_Done  (Self :  access Gtk_Button_Record'Class) is
   begin
      for I in Index_range loop
         if Get_Active(If_active(I)) then
            additional_sensors_states(I) := true;
         else
            additional_sensors_states(I) := false;
         end if;
         
         if Get_Active(If_entrance(I)) then
            If_Entrance_bool(I) := true;
         else 
            If_Entrance_bool(I) := false;
         end if;
         
         case Get_Active_Text(Groups(I))(1) is
           when '1' => Group_no(I):=1; 
           when '2' => Group_no(I):=2; 
           when '3' => Group_no(I):=3; 
           when '4' => Group_no(I):=4; 
           when '5' => Group_no(I):=5; 
           when others => Group_no(I):=1;
         end case;
         
         Sensor_loc(I) := TO_Unbounded_String(Get_Text(Room(I)));
         
      end loop;
      
      Stack.Set_Visible_Child_Name("Keyboard_view");
   end Configuration_Done;
   
   ------ Keyboard view---------------------------------------------------------
   procedure Menu_clicked (Self :  access Gtk_Button_Record'Class) is
   begin
      for I in Index_range loop
         if additional_sensors_states(I) then
            tmp := To_Unbounded_String("Sensor ");
            Append(tmp, Integer'Image(I));
            Append(tmp, "  ");
            Append(tmp, Sensor_loc(I));
            Append(tmp, "  ");
            Append(tmp, Integer'Image(Group_no(I)));
            Sens_to_lab(I).Set_Text(To_String(tmp));        
         end if;      
      end loop;
      
      Stack.Set_Visible_Child_Name("Menu_view");
   end Menu_clicked;
   
   procedure Back_clicked (Self :  access Gtk_Button_Record'Class) is
   begin
      Clear_Not_clicked;
      Stack.Set_Visible_Child_Name("Keyboard_view");
   end Back_clicked;
   
      
   procedure Zero_clicked (Self :  access Gtk_Button_Record'Class) is
   begin
      Update_Label('0');
   end Zero_clicked;
     
   procedure One_clicked (Self :  access Gtk_Button_Record'Class) is
   begin
      Put(Ada.Characters.Latin_1.BEL);
      Put(Character'Val(7));
      Update_Label('1');
   end One_clicked;
     
   procedure Two_clicked (Self :  access Gtk_Button_Record'Class) is
   begin
      Update_Label('2');
   end Two_clicked;
     
   procedure Three_clicked (Self :  access Gtk_Button_Record'Class) is
   begin
      Update_Label('3');
   end Three_clicked;
      
   procedure Four_clicked (Self :  access Gtk_Button_Record'Class) is
   begin
      Update_Label('4');
   end Four_clicked;
      
   procedure Five_clicked (Self :  access Gtk_Button_Record'Class) is
   begin
      Update_Label('5');
   end Five_clicked;
     
   procedure Six_clicked (Self :  access Gtk_Button_Record'Class) is
   begin
      Update_Label('6');
   end Six_clicked;
     
   procedure Seven_clicked (Self :  access Gtk_Button_Record'Class) is
   begin
      Update_Label('7');
   end Seven_clicked;
     
   procedure Eight_clicked (Self :  access Gtk_Button_Record'Class) is
   begin
      Update_Label('8');
   end Eight_clicked;
     
   procedure Nine_clicked (Self :  access Gtk_Button_Record'Class) is
   begin
      Update_Label('9');
   end Nine_clicked;
     
   procedure Clear_clicked (Self :  access Gtk_Button_Record'Class) is
   begin
      Label.Set_Text("----");
      WrongPass.Set_Text("");
      PIN_counter := 1;
   end Clear_clicked;
        
   procedure Clear_Not_clicked  is
   begin
      Label.Set_Text("----");
      PIN_counter := 1;
   end Clear_Not_clicked;
   
   ------------- Change Pin View -----------------------------------------------
   
   procedure Zero_clickedCh (Self :  access Gtk_Button_Record'Class) is
   begin
      Update_LabelCh('0');
   end Zero_clickedCh;
     
   procedure One_clickedCh (Self :  access Gtk_Button_Record'Class) is
   begin
      Update_LabelCh('1');
   end One_clickedCh;
     
   procedure Two_clickedCh (Self :  access Gtk_Button_Record'Class) is
   begin
      Update_LabelCh('2');
   end Two_clickedCh;
     
   procedure Three_clickedCh (Self :  access Gtk_Button_Record'Class) is
   begin
      Update_LabelCh('3');
   end Three_clickedCh;
      
   procedure Four_clickedCh (Self :  access Gtk_Button_Record'Class) is
   begin
      Update_LabelCh('4');
   end Four_clickedCh;
      
   procedure Five_clickedCh (Self :  access Gtk_Button_Record'Class) is
   begin
      Update_LabelCh('5');
   end Five_clickedCh;
     
   procedure Six_clickedCh (Self :  access Gtk_Button_Record'Class) is
   begin
      Update_LabelCh('6');
   end Six_clickedCh;
     
   procedure Seven_clickedCh (Self :  access Gtk_Button_Record'Class) is
   begin
      Update_LabelCh('7');
   end Seven_clickedCh;
     
   procedure Eight_clickedCh (Self :  access Gtk_Button_Record'Class) is
   begin
      Update_LabelCh('8');
   end Eight_clickedCh;
     
   procedure Nine_clickedCh (Self :  access Gtk_Button_Record'Class) is
   begin
      Update_LabelCh('9');
   end Nine_clickedCh;
     
   
   
   procedure Clear_clickedCh (Self :  access Gtk_Button_Record'Class) is
   begin
      New1.Set_Text("Insert old password, then press 'OK'");
      Old.Set_Text("----");
      New2.Set_Text("----");
      PIN_counterCh := 1;
   end Clear_clickedCh;
   
        
   procedure Clear_Not_clickedCh  is
   begin
      Old.Set_Text("----");
      New2.Set_Text("----");
      PIN_counterCh := 1;
   end Clear_Not_clickedCh;
   
   procedure Back_clickedCh (Self :  access Gtk_Button_Record'Class) is
   begin
      Clear_Not_clickedCh;
      Stack.Set_Visible_Child_Name("Menu_view");
   end Back_clickedCh;
   
        
   procedure OK_clickedCh (Self :  access Gtk_Button_Record'Class) is
   begin
      
      if SecondPhaseCh then
         password := Get_Text(New2);
         SecondPhaseCh := false;
         Clear_Not_clickedCh;
         New1.Set_Text("Insert old password, then press 'OK'");
         Stack.Set_Visible_Child_Name("Menu_view");
         
      end if;
      
      if not SecondPhaseCh then
         if (Get_Text(Old) = password) then
            SecondPhaseCh := true;
            PIN_counterCh := 1;
            New1.Set_Text("Insert new password, then press 'OK'");
         end if;
      end if;
            
   end OK_clickedCh;
   
   
   procedure Update_LabelCh (dig : Character) is
   tmp : String := "----";
   begin
      if PIN_counterCh<5 and not SecondPhaseCh then
         tmp := Get_Text(Old);
         tmp(PIN_counterCh) := dig;
         PIN_counterCh := PIN_counterCh+1;
         Old.Set_Text(tmp);
      end if;   
      if PIN_counterCh<5 and SecondPhaseCh then
         tmp := Get_Text(New2);
         tmp(PIN_counterCh) := dig;
         PIN_counterCh := PIN_counterCh+1;
         New2.Set_Text(tmp);
      end if;   
   end Update_LabelCh;
   
   ----------------------------------------------------------------------------
   
   procedure Update_Label (dig : Character) is
   tmp : String := "----";
   begin
      if PIN_counter<5 then
         tmp := Get_Text(Label);
         tmp(PIN_counter) := dig;
         PIN_counter := PIN_counter+1;
      
         Label.Set_Text(tmp);
      end if;   
   end Update_Label;
   
   
   procedure Help_clicked (Self :  access Gtk_Button_Record'Class) is
   begin
      Main_Thread.Call_Police;
      call_flag := true;
      tmp_int := 0;
      Alarm_State.Set_Text("Calling security !");
   end Help_clicked;
   
   procedure Lock_clicked(Self :  access Gtk_Button_Record'Class) is
   begin
      Alarm_State.Set_Text("Alarm state - active");     
      Put_Line("lock clicked");
      
      for I in Index_range loop
         if additional_sensors_states(I) then
            sensors_states(I) := True;
         else
            sensors_states(I) := False;
         end if;
         
      end loop;
      
      
      Main_Thread.Turn_Sensors_On;
   end Lock_clicked;
   
   procedure Start_clicked (Self :  access Gtk_Button_Record'Class) is -- Start is a debug window, made to test the program
   begin
         
      -- Debug window
      Gtk_New(Win_dbg);
      Win_dbg.Set_Default_Size (200, 100);
      Gtk_New_Vbox (Vbox_dbg, True);
      Win_dbg.Add(Vbox_dbg);
   
      Gtk_new(Label_dbg,"Alarm is turned off");
      Gtk_New(Alarm_dbgON,"Alarm on");
      Gtk_New(Alarm_dbgOFF,"Alarm off");
      Gtk_New(Exit_dbg,"Exit");
   
   
      Vbox_dbg.add(Label_dbg);  
      Vbox_dbg.add(Alarm_dbgON);
      Vbox_dbg.add(Alarm_dbgOFF);
      Vbox_dbg.add(Exit_dbg); 
   
      Alarm_dbgON.On_Clicked(DBG_alarmON'Access);
      Alarm_dbgOFF.On_Clicked(DBG_alarmOFF'Access);
      Exit_dbg.On_Clicked(ExitFromDbg'Access);
      
      Win_dbg.Show_All;
      Win_dbg.Present;
   end Start_clicked;
     
   procedure OK_clicked (Self :  access Gtk_Button_Record'Class) is
   begin
      if (Get_Text(Label) = password) and Try_counter<3 then
         Put_Line("inactive");
         Alarm_State.Set_Text("Alarm state - inactive");
         WrongPass.Set_Text("");

              
         for I in Index_Range loop
            sensors_states(I) := false;
            alarms_states(I) := false;
         end loop;
         
         sec45_timer:= 0;
         Main_Thread.Turn_Sensors_Off;
         is_alarm_active := false;
         Clear_Not_clicked;
         Try_counter := 0;
      else
         Try_counter := Try_counter + 1;
         WrongPass.Set_Text("Wrong Password!");
         Clear_Not_clicked;
      end if;
      
      if Try_counter > 2 then
         Main_Thread.Receive_Alarm(0);
         WrongPass.Set_Text("Wrong Password entered too many times! Calling security . . .");
      end if;
      
   end OK_clicked;
   
      
   procedure Change_clicked(Self :  access Gtk_Button_Record'Class) is
   begin
      Stack.Set_Visible_Child_Name("ChangePin_view");
    
   end Change_clicked;
   
   procedure Group_clicked(Self :  access Gtk_Button_Record'Class) is
   begin
         Stack.Set_Visible_Child_Name("Group_view");
      null;
   end Group_clicked;
   
   -------------------------- DBG ---------------------------------
      
   procedure DBG_alarmON(Self :  access Gtk_Button_Record'Class) is
   begin
      Label_dbg.set_text("Alarm is ON");
      is_dbg_active := True;
      drawn := False;
      Random_Alarm_Activation.Start_draw;
   end DBG_alarmON;
   
   procedure DBG_alarmOFF(Self :  access Gtk_Button_Record'Class) is
   begin
      Label_dbg.set_text("Alarm is OFF");
      is_dbg_active := False;
      sec45_timer := 0;
      Turn_Alarm_Off;  
   end DBG_alarmOFF;
   
   procedure ExitFromDbg(Self :  access Gtk_Button_Record'Class) is
   begin
      Win_dbg.Destroy;
   end ExitFromDbg;

   -------------------------- GR ---------------------------------
   
   procedure Gr1_ON(Self :  access Gtk_Button_Record'Class) is 
   begin
      Label_Grp_Info.Set_Text("Group 1 activated");
      for I in Index_range loop
         if additional_sensors_states(I) and Group_no(I) = 1 then
            Put_Line("Gr1:" & I'Img);
            sensors_states(I)  := true;
         end if;
      end loop;
      
      Main_Thread.Turn_Sensors_On;
      Put_Line(is_dbg_active'Img & is_alarm_active'Img);
   end Gr1_ON;
     
   procedure Gr2_ON(Self :  access Gtk_Button_Record'Class) is
   begin
      Label_Grp_Info.Set_Text("Group 2 activated");
      for I in Index_range loop
         if additional_sensors_states(I) and Group_no(I) = 2 then
            sensors_states(I) := true;
         end if;
      end loop;
      
      Main_Thread.Turn_Sensors_On;
      Put_Line(is_dbg_active'Img & is_alarm_active'Img);
   end Gr2_ON;
     
   procedure Gr3_ON(Self :  access Gtk_Button_Record'Class) is
   begin
      Label_Grp_Info.Set_Text("Group 3 activated");
      for I in Index_range loop
         if additional_sensors_states(I) and Group_no(I) = 3 then
            sensors_states(I)  := true;
         end if;
      end loop;
      
      Main_Thread.Turn_Sensors_On;
   end Gr3_ON;
     
   procedure Gr4_ON(Self :  access Gtk_Button_Record'Class) is
   begin
      Label_Grp_Info.Set_Text("Group 4 activated");
      for I in Index_range loop
         if additional_sensors_states(I)  and Group_no(I) =4 then
            sensors_states(I)  := true;
         end if;
      end loop;
      
      Main_Thread.Turn_Sensors_On;
   end Gr4_ON;
     
   procedure Gr5_ON(Self :  access Gtk_Button_Record'Class) is
   begin
      Label_Grp_Info.Set_Text("Group 5 activated");
      for I in Index_range loop
         if additional_sensors_states(I)  and Group_no(I) =5 then
            sensors_states(I)  := true;
         end if;
      end loop;
      
      Main_Thread.Turn_Sensors_On;
      
   end Gr5_ON;
     
   procedure GrBack(Self :  access Gtk_Button_Record'Class) is
   begin
         Label_Grp_Info.Set_Text("");
         Stack.Set_Visible_Child_Name("Menu_view");
   end GrBack;
     
   
   function Alarm_noise return Boolean is --TODO zerowa grupa w ktorej sa nieprzypisane czujniki bo to miesza w losowaniu
      tmp_unbound : Unbounded_String;
   begin
      --Put_Line("Alarm_noise...");
      tmp_int := tmp_int+1;
      for I in Index_range loop
         if call_flag and tmp_int<4 then
            call_flag := false;
            Alarm_State.Set_Text("Calling security !");
            delay 2.0;
            exit;
         elsif sensors_states(I) and alarms_states(I) and is_alarm_active and If_Entrance_bool(I) then -- sensor turned on, alarm turned on, 
            
            Put_Line("Entrance If 1");
            sec45_timer := sec45_timer + 1;
            tmp_unbound := To_Unbounded_String("Alarm state - active - Time to activate alarm: ");
            Append(tmp_unbound, Integer'Image(10-sec45_timer));
            
            Alarm_State.Set_Text(To_String(tmp_unbound));
            
            if sec45_timer>10 then
               Alarm_State.Set_Text("Time excided! Calling security . . .");
               Put_Line("timer:" & sec45_timer'Img);
               tmp_unbound := To_Unbounded_String("Alarm state - active - Sensor ");
               Append(tmp_unbound, Integer'Image(I));
               Append(tmp_unbound, " turned alarm!");
               Alarm_State.Set_Text(To_String(tmp_unbound));
            end if;
            exit;
         elsif sensors_states(I) and alarms_states(I) and is_alarm_active then
            --Put_Line("If 2");
            tmp_unbound := To_Unbounded_String("Alarm state - active - Sensor ");
            Append(tmp_unbound, Integer'Image(I));
            Append(tmp_unbound, " turned alarm!");
            Alarm_State.Set_Text(To_String(tmp_unbound));
            exit;
         elsif sensors_states(I) and is_alarm_active then
            --Put_Line("If 3");
            Alarm_State.Set_Text("Alarm state - active"); 
         elsif is_alarm_active then
            --Put_Line("If 4");
            Alarm_State.Set_Text("Alarm state - active"); 
         else 
            --Put_Line("If 5");
            Alarm_State.Set_Text("Alarm state - inactive");             
         end if;
                  
      end loop;
      if not is_alarm_active then
         Alarm_State.Set_Text("Alarm state - inactive");  
      end if;
      
         
      return True;
   end Alarm_noise;
   
end main_cb;
