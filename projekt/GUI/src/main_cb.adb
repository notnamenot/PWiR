with Ada.Text_IO; use Ada.Text_IO;

with Gtk.Main;

package body main_cb is
   
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
      null;
   end Help_clicked;
   
   procedure Start_clicked (Self :  access Gtk_Button_Record'Class) is
   begin
      null;
   end Start_clicked;
     
   procedure OK_clicked (Self :  access Gtk_Button_Record'Class) is
   begin
      null;
   end OK_clicked;
   
      
   procedure Change_clicked(Self :  access Gtk_Button_Record'Class) is
   begin
      null;
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
