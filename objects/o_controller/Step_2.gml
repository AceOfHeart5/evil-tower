/// @description Sets Prev Vars

// Trigger and axis prev values, needed to determine "pressed"
if (global.usecontroller) {
	global.trigger_left_prev = gamepad_button_value(global.controllerport, gp_shoulderlb);
	global.trigger_right_prev = gamepad_button_value(global.controllerport, gp_shoulderrb);
	global.axis_left_h_prev = gamepad_axis_value(global.controllerport, gp_axislh);
	global.axis_left_v_prev = gamepad_axis_value(global.controllerport, gp_axislv);
	global.axis_right_h_prev = gamepad_axis_value(global.controllerport, gp_axisrh);
	global.axis_right_v_prev = gamepad_axis_value(global.controllerport, gp_axisrv);
}
