/// @description scr_state_plr_airdntorun_change(actor_id)
function scr_state_plr_airdntorun_change() {

	/// @param o_actor

	scr_state_changesprite(argument[0]);
	argument[0].image_index = 3;


}
