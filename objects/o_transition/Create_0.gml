/// @description
/*
When making a new transition object, DO NOT forget to select the "persistent"
box in the object window. Otherwise the transition object will not work 
correctly.
*/
v_transition_targetroom = undefined;
v_transition_alpha = 0;
v_transition_change = 0.07; // amount alpha will change by each alpha change
v_transition_rate = 5; // frames between alpha changes
v_transition_count = v_transition_rate;
v_transition_color1 = c_black;
v_transition_color2 = c_black;
v_transition_color = v_transition_color1;
v_transition_stage = 0;
v_transition_pause = false;
