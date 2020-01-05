with Gtk.Box;         use Gtk.Box;
with Gtk.Label;       use Gtk.Label;
with Gtk.Widget;      use Gtk.Widget;
with Gtk.Main;
with Gtk.Button;      use Gtk.Button;
with Gtk.Window;      use Gtk.Window;
with Gtk.Stack;       use Gtk.Stack;
with Gtk.Handlers;
with main_cb;         use main_cb;

procedure Main is

   Win    : Gtk_Window;

   -----------------------------------

   VBox   : Gtk_Vbox;
   HBox1  : Gtk_Hbox;
   HBox2  : Gtk_Hbox;
   HBox3  : Gtk_Hbox;
   HBox4  : Gtk_Hbox;
   HBox4a : Gtk_Hbox;
   HBox4b : Gtk_Hbox;

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
   ButtonCLR : Gtk_Button;

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

begin
   --  Initialize GtkAda.
   Gtk.Main.Init;

   --  Create a window with a size of 400x400
   Gtk_New (Win);
   Win.Set_Default_Size (400, 400);

   --  Main Window
   Gtk_New (Stack);
   Win.Add (Stack);

   -- Keyboard Windows
   Gtk_New_Vbox (VBox);
   Stack.Add_Named (VBox, "Keyboard_view");

   Gtk_New_Hbox(HBox1, True);
   Gtk_New_Hbox(HBox2, True);
   Gtk_New_Hbox(HBox3, True);
   Gtk_New_Hbox(HBox4, True);
   Gtk_New_Hbox(HBox4a, True);
   Gtk_New_Hbox(HBox4b, True);

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
   Gtk_New (ButtonSTART, "START");
   Gtk_New (ButtonMENU, "MENU");
   Gtk_New (ButtonCLR, "CLEAR");

   --  Add a label
   Gtk_New (Label, "");
   Label.Set_Text("____");
   --Set_Markup(GTk_Label(Label), "<span weight=""bold"" color=""blue"" size=""xx-large"">----</span>");



   --  Packing Boxes
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

   Gtk_new(ButtonNEW, "Add sensor");
   Gtk_new(ButtonDEL, "Delete sensor");
   Gtk_new(ButtonBCK, "Back");
   Gtk_new(ButtonPIN, "Change Pin");

   VBoxM.Add(LabelM_list);
   VBoxM.Add(Sensor1);
   VBoxM.Add(Sensor2);
   VBoxM.Add(ButtonNEW);
   VBoxM.Add(ButtonDEL);
   VBoxM.Add(ButtonPIN);
   VBoxM.Add(ButtonBCK);

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
   ButtonLOCK.On_Clicked(Start_clicked'Access);
   BUttonHELP.On_Clicked(Help_clicked'Access);
   --  Start the Gtk+ main loop
   Gtk.Main.Main;
end Main;
