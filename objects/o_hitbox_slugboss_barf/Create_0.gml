event_inherited();

v_hitbox_projectile = true;

v_hitbox_stun = 20;
v_hitbox_permenant = true;
v_hitbox_target = global.player;
v_hitbox_snd_hit = snd_barf_hit
v_hitbox_fx = o_fx_slug_barf_hit;

v_hitbox_drawsprite = true;
v_hitbox_wallends = true;
v_hitbox_destroyonhit = true;
v_hitbox_vel_x = 1.4;
v_hitbox_vel_y = -0.6;
v_hitbox_grv = 0.011;
v_hitbox_knock_x = 3;
v_hitbox_knock_y = -1;

scr_playsfx_toplayer(x, y, snd_barf);