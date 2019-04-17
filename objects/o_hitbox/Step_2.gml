/// @description Detect Collisions With Target

// generally we won't set the hitterstate if the hitbox is permenant
if (v_hitbox_hitterstate != undefined && v_hitbox_hitter.v_act_state_cur != v_hitbox_hitterstate) {
	instance_destroy(id); // we keep track of attack state of hitter, if they abruptly leave it, delete hitbox
	exit;
}

if (v_hitbox_wallends && place_meeting(x, y, o_wall)) {
	if (v_hitbox_fx != undefined) instance_create_layer(x, y, "Hitboxes", v_hitbox_fx);
	if (v_hitbox_snd_hit != undefined) scr_playsfx(v_hitbox_snd_hit);
	instance_destroy(id);
	exit;
}

/*
Two lists are made for hitboxes each frame, block hits and target hits. Both lists are of actors.
An actor is placed in the block list if:

hitbox collides with block and not target
hitbox collides with block and target, and block and target are on same side of hitter
hitbox collides with block and target, hitter is undefined and block and target are on same side of hitter

In all cases, the actor is not added to the list if the hitbox is already in the hitboxes_struck 
list of the block, or the block doesn't have the hitbox as their target

An actor is placed in the targets list if:

hitbox collides with target and not block
hitbox collides with target and block, and target is not already in blocks list

In all cases the actor is not added to the list if the hitbox is already in the hitboxes_struck
list of the actor.
*/

// first make list of all blocks colliding with hitbox
var blocks = ds_list_create();
instance_place_list(x, y, o_block, blocks, false);

// remove all blocks from the list that don't target this hitbox
for (var i = 0; i < ds_list_size(blocks); i++) {
	if (blocks[|i].v_block_target != object_index) {
		ds_list_delete(blocks, i);
		i--;
	}
}
// remove all blocks where the blocker is not a target of this hitbox
for (var i = 0; i < ds_list_size(blocks); i++) {
	if (blocks[|i].v_block_blocker.object_index != v_hitbox_target) {
		ds_list_delete(blocks, i);
		i--;
	}
}
// remove all blocks from list that already contain this hitbox
for (var i = 0; i < ds_list_size(blocks); i++) {
	if (ds_list_find_index(blocks[|i].v_block_hitboxesblocked, id) >= 0) {
		ds_list_delete(blocks, i);
		i--;
	}
}
// if hitter is defined, remove blocks that aren't between hitbox and target
if (v_hitbox_hitter != undefined) {
	for (var i = 0; i < ds_list_size(blocks); i++) {
		var blockx = blocks[|i].x;
		var targetx = blocks[|i].v_block_blocker.x
		var deleteblock = false;
		if (v_hitbox_hitter.x < blockx && targetx < blockx) deleteblock = true;
		if (v_hitbox_hitter.x > blockx && targetx > blockx) deleteblock = true;
		if (deleteblock) {
			ds_list_delete(blocks, i);
			i--;
		}
	}
} else {
	// if hitter is not defined, same process but using hitbox instead of hitter
	var blockx = blocks[|i].x;
		var targetx = blocks[|i].v_block_blocker.x
		var deleteblock = false;
		if (x < blockx && blockx < targetx) deleteblock = true;
		if (x > blockx && blockx > targetx) deleteblock = true;
		if (deleteblock) {
			ds_list_delete(blocks, i);
			i--;
		}
}

// now we will make a list of all valid target collisions using a similar process
var targets = ds_list_create();
instance_place_list(x, y, v_hitbox_target, targets, false);

// remove all targets that already contain this hitbox
for (var i = 0; i < ds_list_size(targets); i++) {
	if (ds_list_find_index(targets[|i].v_act_hitboxes_struck, id) >= 0) {
		ds_list_delete(targets, i);
		i--;
	}
}
/*
Now we need to remove any targets that are blocking correctly. However...
we have already done this with the blocks list. So all we need to do is 
removed any targets that are already in the blocks list.
*/
for (var i = 0; i < ds_list_size(targets); i++) {
	for (var k = 0; k < ds_list_size(blocks); k ++) {
		if (blocks[|k].v_block_blocker == targets[|i]) {
			k = ds_list_size(blocks);
			ds_list_delete(targets, i);
			i--;
		}
	}
}

// we now have our two lists of blocks and targets

// apply block effects to knockback to blockers
for (var i = 0; i < ds_list_size(blocks); i++) {
	var block = blocks[|i];
	var actor = block.v_block_blocker;
	var state = actor.v_act_state_cur;
	ds_list_add(block.v_block_hitboxesblocked, id);
	actor.v_act_freezetime = v_hitbox_stun;
	state.v_state_defend_time += v_hitbox_stun;
	if (v_hitbox_freezehitter && instance_exists(v_hitbox_hitter)) v_hitbox_hitter.v_act_freezetime = v_hitbox_stun;
	if (block.v_block_fx != undefined) instance_create_layer(block.x, block.y, "Projectiles", block.v_block_fx);
	if (block.v_block_sound != undefined) scr_playsfx(block.v_block_sound);
	if (v_hitbox_destroyonhit) instance_destroy(id);
}

// apply hit effects to targets
for (var i = 0; i < ds_list_size(targets); i++) {
	var actor = targets[|i];
	ds_list_add(actor.v_act_hitboxes_struck, id);
	var hurt = actor.v_act_state_hurt;
	hurt.v_state_hurt_health -= v_hitbox_damage;	
	if (hurt.v_state_hurt_health > 0) {
		actor.v_act_freezetime = v_hitbox_stun;
		actor.v_act_shadertime = v_hitbox_stun;
		actor.v_act_shader = v_hitbox_shader;
		if (v_hitbox_freezehitter && instance_exists(v_hitbox_hitter)) v_hitbox_hitter.v_act_freezetime = v_hitbox_stun;
		hurt.v_state_count = hurt.v_state_count_max;
				
		if (v_hitbox_fx != undefined) instance_create_layer(actor.x, actor.y - hurt.v_state_hurt_fx_yoffset, "Projectiles", v_hitbox_fx);
		if (v_hitbox_snd_hit != undefined) scr_playsfx(v_hitbox_snd_hit);
		if (hurt.v_state_hurt_fx != undefined) instance_create_layer(actor.x, actor.y - hurt.v_state_hurt_fx_yoffset, "Projectiles", hurt.v_state_hurt_fx);
		if (hurt.v_state_hurt_snd != undefined) scr_playsfx(hurt.v_state_hurt_snd);
				
		if (actor.v_act_state_cur != undefined && object_is_ancestor(actor.v_act_state_cur.object_index, o_state_ladder)) {
			hurt.v_state_hurt_ladder = true;
			hurt.v_state_hurt_vel_x = 0;
			hurt.v_state_hurt_vel_y = 0;
		} else {
			hurt.v_state_hurt_ladder = false;
			hurt.v_state_hurt_vel_x = v_hitbox_knock_x;
			if (instance_exists(v_hitbox_hitter) && v_hitbox_hitter.x > actor.x) hurt.v_state_hurt_vel_x *= -1;
			hurt.v_state_hurt_vel_y = v_hitbox_knock_y;
		}
		if (v_hitbox_destroyonhit) instance_destroy(id);
		actor.v_act_state_cur = hurt;
	} else if (hurt.v_state_hurt_dead_scene == undefined) {
		// we won't bother creating death effects if there is a death scene, we'll assume that handles everything
		if (hurt.v_state_hurt_dead_fx != undefined) instance_create_layer(actor.x, actor.y, "Projectiles", hurt.v_state_hurt_dead_fx);
		if (hurt.v_state_hurt_dead_snd != undefined) scr_playsfx(hurt.v_state_hurt_dead_snd);
		ds_list_add(global.enemies_slain, actor);
		instance_destroy(actor);
	}
}

if (v_hitbox_firstcheck && 
	ds_list_size(blocks) == 0 && 
	ds_list_size(targets) == 0) scr_playsfx(v_hitbox_snd_miss);

v_hitbox_firstcheck = false;

ds_list_destroy(blocks);
ds_list_destroy(targets);