/// @description scr_state_idle_connection(actor_id)

/// @param actor_id

var result = false;

var actcontroller = argument[0].v_act_controller;

if (argument[0].v_act_vel_x == 0
&& argument[0].v_act_vel_y == 0
/*
&& actcontroller.v_actcon_left == false
&& actcontroller.v_actcon_right == false
&& actcontroller.v_actcon_button1 == false
&& actcontroller.v_actcon_button2 == false
&& actcontroller.v_actcon_button3 == false
&& actcontroller.v_actcon_pressed_up == false
&& actcontroller.v_actcon_pressed_down == false
&& actcontroller.v_actcon_pressed_left == false
&& actcontroller.v_actcon_pressed_right == false
&& actcontroller.v_actcon_pressed_button1 == false
&& actcontroller.v_actcon_pressed_button2 == false
&& actcontroller.v_actcon_pressed_button3 == false
*/
&& !place_meeting(argument[0].x, argument[0].y, o_wall)
&& place_meeting(argument[0].x, argument[0].y + 1, o_wall)) result = true;

return result;
