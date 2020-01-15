with Gtk.Box;         use Gtk.Box;
with Gtk.Label;       use Gtk.Label;
with Gtk.Widget;      use Gtk.Widget;
with Gtk.Main;
with Gtk.Button;      use Gtk.Button;
with Gtk.Window;      use Gtk.Window;
with Gtk.Stack;       use Gtk.Stack;
with Gtk.Handlers;
with main_cb;         use main_cb;
with Glib.Main;       use Glib.Main;
with alarms_pkg;      use alarms_pkg;
with Gdk.Display;     use Gdk.Display;
with Ada.Text_IO, Ada.Numerics.Discrete_Random, Ada.Task_Identification;
use Ada.Text_IO, Ada.Task_Identification;

procedure Main is

   Win        : Gtk_Window;
--timeout
   -----------------------------------

   VBox       : Gtk_Vbox;
   HBox1      : Gtk_Hbox;
   HBox2      : Gtk_Hbox;
   HBox3      : Gtk_Hbox;
   HBox4      : Gtk_Hbox;

   Button0    : Gtk_Button;
   Button1    : Gtk_Button;
   Button2    : Gtk_Button;
   Button3    : Gtk_Button;
   Button4    : Gtk_Button;
   Button5    : Gtk_Button;
   Button6    : Gtk_Button;
   Button7    : Gtk_Button;
   Button8    : Gtk_Button;
   Button9    : Gtk_Button;

   ButtonOK   : Gtk_Button;
   ButtonLOCK : Gtk_Button;
   ButtonHELP : Gtk_Button;
   ButtonCLR  : Gtk_Button;

   ButtonSTART: Gtk_Button;
   ButtonMENU : Gtk.Button.Gtk_Button;

   -----------------------------------

   VBoxM      : Gtk_Vbox;
   LabelM_list: Gtk_Label;
   ButtonNEW  : Gtk_Button;
   ButtonDEL  : Gtk_Button;
   ButtonBCK  : Gtk_Button;
   ButtonPIN  : Gtk_Button;
   Sensor1    : Gtk_Label;
   Sensor2    : Gtk_Label;
   Sensor3    : Gtk_Label;

   ----------------------------------

   VBoxCh     : Gtk_Vbox;
   HBox1Ch    : Gtk_Hbox;
   HBox2Ch    : Gtk_Hbox;
   HBox3Ch    : Gtk_Hbox;
   HBox4Ch    : Gtk_Hbox;

   Button0Ch  : Gtk_Button;
   Button1Ch  : Gtk_Button;
   Button2Ch  : Gtk_Button;
   Button3Ch  : Gtk_Button;
   Button4Ch  : Gtk_Button;
   Button5Ch  : Gtk_Button;
   Button6Ch  : Gtk_Button;
   Button7Ch  : Gtk_Button;
   Button8Ch  : Gtk_Button;
   Button9Ch  : Gtk_Button;

   ButtonOKCh : Gtk_Button;
   ButtonBCKCh: Gtk_Button;
   ButtonCLRCh: Gtk_Button;




   ----------------------------------
   Zn: Character := ' ';
   Timeout_ID : Glib.Main.G_Source_Id;
   beep_char  : Integer := 7;

begin
   --  Initialize GtkAda.
   Gtk.Main.Init;

   --  Create a window with a size of 400x400
   Gtk_New (Win);
   Win.Set_Default_Size (400, 400);

   Win.On_Destroy (main_quit'Access);


   --  Main Window
   Gtk_New (Stack);
   Win.Add (Stack);

   -- Keyboard Window
   Gtk_New_Vbox (VBox);
   Stack.Add_Named (VBox, "Keyboard_view");

   Gtk_New_Hbox(HBox1, True);
   Gtk_New_Hbox(HBox2, True);
   Gtk_New_Hbox(HBox3, True);
   Gtk_New_Hbox(HBox4, True);

   -- Create a buttons
   Gtk_New (Button0, "0");
   Gtk_New (Button1, "1");
   Gtk_New (Button2, "2");
   Gtk_New (Button3, "3");
   Gtk_New (Button4, "4");
   Gtk_New (Button5, "5");
   Gtk_New (Button6, "6");
   Gtk_New (Button7, "7");
   Gtk_New (Button8, "8");
   Gtk_New (Button9, "9");

   Gtk_New (ButtonOK, "OK");
   Gtk_New (ButtonLOCK, "LOCK");
   Gtk_New (ButtonHELP, "HELP");
   Gtk_New (ButtonSTART, "DBG");
   Gtk_New (ButtonMENU, "MENU");
   Gtk_New (ButtonCLR, "CLEAR");

   --  Add a label
   Gtk_New (Label, "");
   Gtk_New (WrongPass, "");
   Label.Set_Text("____");

   Gtk_New (Alarm_State, "Alarm state - inactive");
   --Set_Markup(GTk_Label(Label), "<span weight=""bold"" color=""blue"" size=""xx-large"">----</span>");



   --  Keyboard
   VBox.Add (Alarm_State);
   VBox.Add (WrongPass);
   VBox.Add (Label);
   VBox.Add (HBox1);
   VBox.Add (HBox2);
   VBox.Add (HBox3);
   VBox.Add (HBox4);

   HBox1.Add(Button1);
   HBox1.Add(Button2);
   HBox1.Add(Button3);
   HBox1.Add(BUttonSTART);


   HBox2.Add(Button4);
   HBox2.Add(Button5);
   HBox2.Add(Button6);
   HBox2.Add(ButtonMENU);


   HBox3.Add(Button7);
   HBox3.Add(Button8);
   HBox3.Add(Button9);
   HBox3.Add(BUttonHELP);

   HBox4.Add(ButtonOK);
   HBox4.Add(Button0);

   HBox4.Add(ButtonLOCK);
   HBox4.Add(ButtonCLR);

   --  Menu Window
   Gtk_New_Vbox (VBoxM, True);
   Stack.Add_Named (VBoxM, "Menu_view");

   Gtk_new(LabelM_list, "Name----ID----Location");
   Gtk_new(Sensor1, "Sensor1 0001 Living Room");
   Gtk_new(Sensor2, "Sensor2 0002 Bedroom no 1");
   Gtk_new(Sensor3, "Sensor3 0003 Bedroom no 2");

   Gtk_new(ButtonNEW, "Add sensor");
   Gtk_new(ButtonDEL, "Delete sensor");
   Gtk_new(ButtonBCK, "Back");
   Gtk_new(ButtonPIN, "Change Pin");

   VBoxM.Add(LabelM_list);
   VBoxM.Add(Sensor1);
   VBoxM.Add(Sensor2);
   VBoxM.Add(Sensor3);
   --VBoxM.Add(ButtonNEW);
   --VBoxM.Add(ButtonDEL);
   VBoxM.Add(ButtonPIN);
   VBoxM.Add(ButtonBCK);

   -- Change pin

   Gtk_New_Vbox (VBoxCh, True);
   Stack.Add_Named (VBoxCh, "ChangePin_view");

   Gtk_New_Hbox(HBox1Ch, True);
   Gtk_New_Hbox(HBox2Ch, True);
   Gtk_New_Hbox(HBox3Ch, True);
   Gtk_New_Hbox(HBox4Ch, True);

   Gtk_New (New1, "Insert old password, then press 'OK'");
   Gtk_New (Old, "----");
   Gtk_New (New2, "----");

   VBoxCh.Add(New1);
   VBoxCh.Add(Old);
   VBoxCh.Add(New2);


   VBoxCh.Add(HBox1Ch);
   VBoxCh.Add(HBox2Ch);
   VBoxCh.Add(HBox3Ch);
   VBoxCh.Add(HBox4Ch);

   Gtk_New (Button0Ch, "0");
   Gtk_New (Button1Ch, "1");
   Gtk_New (Button2Ch, "2");
   Gtk_New (Button3Ch, "3");
   Gtk_New (Button4Ch, "4");
   Gtk_New (Button5Ch, "5");
   Gtk_New (Button6Ch, "6");
   Gtk_New (Button7Ch, "7");
   Gtk_New (Button8Ch, "8");
   Gtk_New (Button9Ch, "9");

   Gtk_New (ButtonOKCh, "OK");
   Gtk_New (ButtonCLRCh, "Clear");
   Gtk_New (ButtonBCKCh, "Back");


   HBox1Ch.Add(Button1Ch);
   HBox1Ch.Add(Button2Ch);
   HBox1Ch.Add(Button3Ch);

   HBox2Ch.Add(Button4Ch);
   HBox2Ch.Add(Button5Ch);
   HBox2Ch.Add(Button6Ch);

   HBox3Ch.Add(Button7Ch);
   HBox3Ch.Add(Button8Ch);
   HBox3Ch.Add(Button9Ch);


   HBox4Ch.Add(ButtonOKCh);
   HBox4Ch.Add(Button0Ch);
   HBox4Ch.Add(ButtonCLRCh);


   VBoxCh.Add(ButtonBCKCh);

   --  Show the window and present it
   Win.Show_All;
   Win.Present;

   -- Buttons Handlers
   ButtonMENU.On_Clicked(Menu_clicked'Access);
   ButtonBCK.On_Clicked(Back_clicked'Access);


   Button0.On_Clicked(Zero_clicked'Access);
   Button1.On_Clicked(One_clicked'Access);
   Button2.On_Clicked(Two_clicked'Access);
   Button3.On_Clicked(Three_clicked'Access);
   Button4.On_Clicked(Four_clicked'Access);
   Button5.On_Clicked(Five_clicked'Access);
   Button6.On_Clicked(Six_clicked'Access);
   Button7.On_Clicked(Seven_clicked'Access);
   Button8.On_Clicked(Eight_clicked'Access);
   Button9.On_Clicked(Nine_clicked'Access);

   ButtonCLR.On_Clicked(Clear_clicked'Access);


   ButtonNEW.On_Clicked(Add_clicked'Access);
   ButtonDEL.On_Clicked(Del_clicked'Access);
   ButtonPIN.On_Clicked(Change_clicked'Access);
   ButtonOK.On_Clicked(OK_clicked'Access);
   BUttonSTART.On_Clicked(Start_clicked'Access);
   ButtonLOCK.On_Clicked(Lock_clicked'Access);
   BUttonHELP.On_Clicked(Help_clicked'Access);


   Button0Ch.On_Clicked(Zero_clickedCh'Access);
   Button1Ch.On_Clicked(One_clickedCh'Access);
   Button2Ch.On_Clicked(Two_clickedCh'Access);
   Button3Ch.On_Clicked(Three_clickedCh'Access);
   Button4Ch.On_Clicked(Four_clickedCh'Access);
   Button5Ch.On_Clicked(Five_clickedCh'Access);
   Button6Ch.On_Clicked(Six_clickedCh'Access);
   Button7Ch.On_Clicked(Seven_clickedCh'Access);
   Button8Ch.On_Clicked(Eight_clickedCh'Access);
   Button9Ch.On_Clicked(Nine_clickedCh'Access);

   ButtonOKCh.On_Clicked(OK_clickedCh'Access);
   ButtonCLRCh.On_Clicked(Clear_clickedCh'Access);
   ButtonBCKCh.On_Clicked(Back_clickedCh'Access);

   Timeout_ID := Timeout_Add(750, Alarm_noise'Access);
   --  Start the Gtk+ main loop
   Gtk.Main.Main;

end Main;
