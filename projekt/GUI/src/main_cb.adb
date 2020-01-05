with Ada.Text_IO; use Ada.Text_IO;

with Gtk.Main;

package body main_cb is
   ------Keyboard view---------------------------------------------------------
   procedure Menu_clicked (Self :  access Gtk_Button_Record'Class) is
   begin
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
      PIN_counter := 1;
   end Clear_clicked;
   
        
   procedure Clear_Not_clicked  is
   begin
      Label.Set_Text("----");
      PIN_counter := 1;
   end Clear_Not_clicked;
   
   -------------Change Pin View -----------------------------------------------
   
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
   end Help_clicked;
   
   procedure Start_clicked (Self :  access Gtk_Button_Record'Class) is
   begin
      Alarm_State.Set_Text("Alarm state - active");
                             
      Main_Thread.Turn_On_Alarm;
   end Start_clicked;
     
   procedure OK_clicked (Self :  access Gtk_Button_Record'Class) is
   begin
      if (Get_Text(Label) = password) and Try_counter<6 then
         Alarm_State.Set_Text("Alarm state - inactive");
         Main_Thread.Turn_Off_Alarm;
         Try_counter := 0;
      else
         Try_counter := Try_counter + 1;
      end if;
      
      if Try_counter > 5 then
         Main_Thread.Receive_Alarm(0);
      end if;
      
   end OK_clicked;
   
      
   procedure Change_clicked(Self :  access Gtk_Button_Record'Class) is
   begin
      Stack.Set_Visible_Child_Name("ChangePin_view");
    
   end Change_clicked;
   
   procedure Add_clicked(Self :  access Gtk_Button_Record'Class) is
   begin
      null;
   end Add_clicked;
   
   procedure Del_clicked(Self :  access Gtk_Button_Record'Class) is
   begin
      null;
   end Del_clicked;
   
   
end main_cb;
