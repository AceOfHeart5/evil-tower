/// @description scr_state_ladder_down_continue(o_actor)
/// @param actor_id
function scr_state_ladder_down_continue() {

	var ID = argument[0];
	var actcon = ID.v_act_actcon;
	var result = false;

	if (actcon.v_actcon_down) result = true;

	// if the bottom edge is about to be off ladder, we need to check some things.
	if (!position_meeting(ID.x, ID.bbox_bottom + 1, o_ladder)) {
		if (position_meeting(ID.x, ID.bbox_bottom + 1, o_wall)) result = false;
		if (!place_meeting(ID.x, ID.y + 1, o_ladder)) result = false;
	}

	if (actcon.v_actcon_pressed_up ||
		//actcon.v_actcon_pressed_left ||
		//actcon.v_actcon_pressed_right ||
		actcon.v_actcon_pressed_button1 ||
		actcon.v_actcon_pressed_button2 ||
		actcon.v_actcon_pressed_button3) {
			result = false;
			ID.v_act_vel_y = 0;
		}

	return result;



}
