with Gtk.Widget;   use Gtk.Widget;
with Gtk.Button;   use Gtk.Button;
with Gtk.Label;    use Gtk.Label;
with Glib.Object;
with Gdk.Event;
with Gtk.Stack;    use Gtk.Stack;
with alarms_pkg;      use alarms_pkg;
with Gtk.Window;      use Gtk.Window;

package main_cb is
   
   Stack : Gtk_Stack;
   Label  : Gtk_Label;
   WinChange : Gtk_Window;
   
   PIN_counter : Integer := 1;
   PIN_counterCh : Integer := 1;
   SecondPhaseCh : Boolean := false;
   
   Try_counter : Integer := 0;
   
   Alarm_State: Gtk_Label;
   Old: Gtk_Label;
   New1: Gtk_Label;
   New2: Gtk_Label;
   
   WrongPass : Gtk_Label;
   
   procedure main_quit(Self : access Gtk_Widget_Record'Class); 
   procedure Menu_clicked (Self :  access Gtk_Button_Record'Class);
   procedure Back_clicked (Self :  access Gtk_Button_Record'Class);
   
   procedure Zero_clicked (Self :  access Gtk_Button_Record'Class);
   procedure One_clicked (Self :  access Gtk_Button_Record'Class);
   procedure Two_clicked (Self :  access Gtk_Button_Record'Class);
   procedure Three_clicked (Self :  access Gtk_Button_Record'Class);
   procedure Four_clicked (Self :  access Gtk_Button_Record'Class);
   procedure Five_clicked (Self :  access Gtk_Button_Record'Class);
   procedure Six_clicked (Self :  access Gtk_Button_Record'Class);
   procedure Seven_clicked (Self :  access Gtk_Button_Record'Class);
   procedure Eight_clicked (Self :  access Gtk_Button_Record'Class);
   procedure Nine_clicked (Self :  access Gtk_Button_Record'Class);
   
   procedure Clear_clicked (Self :  access Gtk_Button_Record'Class);

   
   procedure Update_Label (dig : Character);
   procedure Clear_Not_clicked ;
-- TODO
   procedure Help_clicked(Self :  access Gtk_Button_Record'Class);
   
   procedure Start_clicked(Self :  access Gtk_Button_Record'Class);
   
   procedure OK_clicked(Self :  access Gtk_Button_Record'Class);
   
   procedure Change_clicked(Self :  access Gtk_Button_Record'Class);
   
   procedure Add_clicked(Self :  access Gtk_Button_Record'Class);
   
   procedure Del_clicked(Self :  access Gtk_Button_Record'Class);
   
   
         
   procedure Zero_clickedCh (Self :  access Gtk_Button_Record'Class);
   procedure One_clickedCh (Self :  access Gtk_Button_Record'Class);
   procedure Two_clickedCh (Self :  access Gtk_Button_Record'Class);
   procedure Three_clickedCh (Self :  access Gtk_Button_Record'Class);
   procedure Four_clickedCh (Self :  access Gtk_Button_Record'Class);
   procedure Five_clickedCh (Self :  access Gtk_Button_Record'Class);
   procedure Six_clickedCh (Self :  access Gtk_Button_Record'Class);
   procedure Seven_clickedCh (Self :  access Gtk_Button_Record'Class);
   procedure Eight_clickedCh (Self :  access Gtk_Button_Record'Class);
   procedure Nine_clickedCh (Self :  access Gtk_Button_Record'Class);
   
   procedure Clear_clickedCh (Self :  access Gtk_Button_Record'Class);
   procedure Clear_Not_clickedCh ;
   procedure Back_clickedCh (Self :  access Gtk_Button_Record'Class);
   procedure OK_clickedCh (Self :  access Gtk_Button_Record'Class);
   
   
   procedure Update_LabelCh (dig : Character);
   
end main_cb;
