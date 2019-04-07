event_inherited();

// hurt state
v_act_state_hurt = instance_create_layer(x, y, "Enemies", o_state_hurt);
v_act_state_hurt.v_state_count_max = 20;
v_act_state_hurt.v_state_hurt_health = 3;
v_act_state_hurt.v_state_hurt_knock_y = -1.5;
v_act_state_hurt.v_state_hurt_vel_y_max = 3;

// hitbox
v_act_hitbox = instance_create_layer(x, y, "Hitboxes", o_hitbox);
v_act_hitbox.sprite_index = sprite_index; //use the same sprite as the enemy
v_act_hitbox.v_hitbox_effect = undefined;
v_act_hitbox.v_hitbox_target = global.player;
v_act_hitbox.v_hitbox_stun = 7;
v_act_hitbox.v_hitbox_permenant = true;
v_act_hitbox.v_hitbox_damage = 1;

v_act_dead_fx = o_fx_explosion;
