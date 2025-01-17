/// @description Insert description here

/*
There are a lot of calls to draw_text_transformed here. We used to use a system
that resized the text based on the game resolution. But we're not going to do that
anymore, so all instances of the menu_scale variables have been replaced with 1.
*/

if (global.pauseactive) {
	v_pausemenu_rectwidth = v_pausemenu_rectwidth_max;
	v_pausemenu_rectheight = v_pausemenu_rectheight_max;
	v_pausemenu_rectx = global.resolution_width/2 - v_pausemenu_rectwidth/2;
	v_pausemenu_recty = global.resolution_height/2 - v_pausemenu_rectheight/2;
	draw_set_color(c_black);
	draw_set_alpha(v_pausemenu_alpha);
	draw_rectangle(0, 0, global.resolution_width, global.resolution_height, false);
	
	//menu panel
	var x2 = v_pausemenu_rectx + v_pausemenu_rectwidth;
	var y2 = v_pausemenu_recty + v_pausemenu_rectheight;
	var borderx = v_pausemenu_border;
	var bordery = v_pausemenu_border;
	
	draw_set_alpha(1);
	draw_set_color(c_red);
	draw_rectangle(v_pausemenu_rectx, v_pausemenu_recty, x2, y2, false);
	
	draw_set_color(c_black);
	draw_rectangle(v_pausemenu_rectx + borderx, v_pausemenu_recty + bordery, x2 - borderx, y2 - bordery, false);

	//menu text
	draw_set_font(v_pausemenu_font);
	draw_set_halign(fa_center);
	draw_set_valign(fa_bottom);
	if (v_pausemenu_control) {
		v_pausemenu_blinkalpha += v_pausemenu_blinkrate;
		if (v_pausemenu_blinkalpha > v_pausemenu_maxalpha) {
			v_pausemenu_blinkalpha = v_pausemenu_maxalpha;
			v_pausemenu_blinkrate = v_pausemenu_blinkrate * -1;
		}
		if (v_pausemenu_blinkalpha < 0) {
			v_pausemenu_blinkalpha = 0;
			v_pausemenu_blinkrate = v_pausemenu_blinkrate * -1;
		}	
	}
	for (i = 0; i < v_pausemenu_items; i++) {//remember that this is drawing bottom up
		var txt = v_pausemenu[i];
		var cursor = "";
		var color = c_dkgray;
		if (v_pausemenu_cursor == i) {
			cursor = string_insert(">", cursor, 0);
			color = c_white;
		}
		v_pausemenu_x = global.resolution_width/2;
		v_pausemenu_y = global.resolution_height/2;
		var xx = v_pausemenu_x;
		var yy = v_pausemenu_y - v_pausemenu_itemheight * i * v_pausemenu_spacer;//could use scale_x, doesn't matter
		draw_set_color(color);
		draw_set_alpha(1);
		draw_text_transformed(global.resolution_width/v_pausemenu_pointerxxdivide, yy, cursor, 1, 1, 0);
		draw_text_transformed(xx, yy, txt, 1, 1, 0);

		//make chosen option blink tastfully
		if (v_pausemenu_cursor == i) {
			draw_set_color(c_black);
			draw_set_alpha(v_pausemenu_blinkalpha);
			draw_text_transformed(xx, yy, txt, 1, 1, 0);
		}
	}
}