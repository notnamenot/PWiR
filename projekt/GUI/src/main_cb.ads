with Gtk.Widget;   use Gtk.Widget;
with Gtk.Button;   use Gtk.Button;
with Gtk.Label;    use Gtk.Label;
with Glib.Object;
with Gdk.Event;
with Gtk.Stack;    use Gtk.Stack;

package main_cb is
   
   Stack : Gtk_Stack;
   Label  : Gtk_Label;
   
   PIN_counter : Integer := 1;
   
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
end main_cb;
