with Gtk.Box;         use Gtk.Box;
with Gtk.Label;       use Gtk.Label;
with Gtk.Widget;      use Gtk.Widget;
with Gtk.Main;
with Gtk.Button;      use Gtk.Button;
with Gtk.Window;      use Gtk.Window;
with Gtk.Stack;       use Gtk.Stack;
with Gtk.Handlers;
with main_cb;         use main_cb;
with Glib;            use Glib;
with Glib.Main;       use Glib.Main;
with alarms_pkg;      use alarms_pkg;
with Gdk.Display;     use Gdk.Display;
with Gtk.Combo_Box_Text;     use Gtk.Combo_Box_Text;
with Gtk.GEntry;      use Gtk.GEntry;
with Glib.Main;       use Glib.Main;
with Gtk.List_Store;  use Gtk.List_Store;

with Gtk.Toggle_Button; use Gtk.Toggle_Button;
with Gtk.Check_Button;  use Gtk.Check_Button;
with Ada.Text_IO, Ada.Numerics.Discrete_Random, Ada.Task_Identification;
use Ada.Text_IO, Ada.Task_Identification;

procedure Main is

   Win        : Gtk_Window;

   -----------------Keyboard view------------------

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

   -----------------Menu view------------------

   VBoxM      : Gtk_Vbox;
   LabelM_list: Gtk_Label;
   ButtonGRP  : Gtk_Button;
   ButtonBCK  : Gtk_Button;
   ButtonPIN  : Gtk_Button;

   -----------------Change pin view-----------------

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

   ----------------Turn By Group--------------------
   Vbox_grp   : Gtk_Vbox;
   Label_Grp  : Gtk_Label;
   Grp1       : Gtk_Button;
   Grp2       : Gtk_Button;
   Grp3       : Gtk_Button;
   Grp4       : Gtk_Button;
   Grp5       : Gtk_Button;
   Grp_Back   : Gtk_Button;

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

   -- Initial configuration
   Gtk_New_Vbox (Vbox_conf);
   Stack.Add_Named (Vbox_conf, "Init_config_view");
   Gtk_New(Label_info1, "Add your sensors");

   Gtk_New(Label_head1, "Sensor ID |");
   Gtk_New(Label_head2, "Add |");
   Gtk_New(Label_head3, "Is Entrance |");
   Gtk_New(Label_head4, "Location |");
   Gtk_New(Label_head5, "Sensor Group");


   Vbox_conf.Add(Label_info1);

   Gtk_New(Label_num(1), "Sensor 1");
   Gtk_New(Label_num(2), "Sensor 2");
   Gtk_New(Label_num(3), "Sensor 3");
   Gtk_New(Label_num(4), "Sensor 4");
   Gtk_New(Label_num(5), "Sensor 5");
   Gtk_New(Label_num(6), "Sensor 6");
   Gtk_New(Label_num(7), "Sensor 7");
   Gtk_New(Label_num(8), "Sensor 8");
   Gtk_New(Label_num(9), "Sensor 9");
   Gtk_New(Label_num(10), "Sensor 10");


   Gtk_New_Hbox(Hbox_conf(0),Spacing => 5);
   Hbox_conf(0).Add(Label_head1);
   Hbox_conf(0).Add(Label_head2);
   Hbox_conf(0).Add(Label_head3);
   Hbox_conf(0).Add(Label_head4);
   Hbox_conf(0).Add(Label_head5);

   Vbox_conf.Add(Hbox_conf(0));


   for I in Integer range 1..10 loop
      Gtk_New_Hbox(Hbox_conf(I),Spacing => 5);
      Gtk_New(If_active(I));
      Gtk_New(If_entrance(I));
      Gtk_New(Room(I));
      Gtk_New(Groups(I));

      Append_Text (Groups(I), "1");
      Append_Text (Groups(I), "2");
      Append_Text (Groups(I), "3");
      Append_Text (Groups(I), "4");
      Append_Text (Groups(I), "5");

      Set_Active (Groups(I), 0);

      Hbox_conf(I).Add(Label_num(I));
      Hbox_conf(I).Add(If_active(I));
      Hbox_conf(I).Add(If_entrance(I));
      Hbox_conf(I).Add(Room(I));
      Hbox_conf(I).Add(Groups(I));

      Vbox_conf.Add(Hbox_conf(I));
   end loop;

   Gtk_New(Done_Btn, "Done");
   Vbox_conf.Add(Done_Btn);


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

   Gtk_new(LabelM_list, "Name----Location----Group");

   Gtk_new(ButtonGRP, "Turn by group");
   Gtk_new(ButtonBCK, "Back");
   Gtk_new(ButtonPIN, "Change Pin");

   VBoxM.Add(LabelM_list);

   for J in Integer range 1..10 loop

      Gtk_New(Sens_to_lab(J), "");
      VBoxM.Add(Sens_to_lab(J));

   end loop;

   VBoxM.Add(ButtonGRP);
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

   --Group view
   Gtk_New_Vbox(Vbox_grp, True);
   Stack.Add_Named(Vbox_grp, "Group_view");


   Gtk_New(Label_Grp, "Choose which group turn on");
   Gtk_New(Label_Grp_Info, "");
   Gtk_New(Grp1, "Group 1");
   Gtk_New(Grp2, "Group 2");
   Gtk_New(Grp3, "Group 3");
   Gtk_New(Grp4, "Group 4");
   Gtk_New(Grp5, "Group 5");
   Gtk_New(Grp_Back, "Back");

   Vbox_grp.Add(Label_Grp);
   Vbox_grp.Add(Label_Grp_Info);
   Vbox_grp.Add(Grp1);
   Vbox_grp.Add(Grp2);
   Vbox_grp.Add(Grp3);
   Vbox_grp.Add(Grp4);
   Vbox_grp.Add(Grp5);
   Vbox_grp.Add(Grp_Back);


   --  Show the window and present it
   Win.Show_All;
   Win.Present;

   -- Buttons Handlers
   Done_Btn.On_Clicked(Configuration_Done'Access);

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


   ButtonGRP.On_Clicked(Group_clicked'Access);
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

   Grp1.On_Clicked(Gr1_on'Access);
   Grp2.On_Clicked(Gr2_on'Access);
   Grp3.On_Clicked(Gr3_on'Access);
   Grp4.On_Clicked(Gr4_on'Access);
   Grp5.On_Clicked(Gr5_on'Access);
   Grp_Back.On_Clicked(GrBack'Access);

   Timeout_ID := Timeout_Add(1000, Alarm_noise'Access);
   --  Start the Gtk+ main loop
   Gtk.Main.Main;

end Main;
