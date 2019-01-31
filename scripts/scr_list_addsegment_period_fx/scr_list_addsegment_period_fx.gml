/// @description scr_list_addsegment_period(list, text, word_color, period_color, startnewline, fxphys, fxcolr, font)

/// @param list
/// @param text
/// @param word_color
/// @param period_color
/// @param startnewline
/// @param fxphys
/// @param fxcolr
/// @param font

var t_segment_wperiod = instance_create_layer(0, 0, "Text", o_segment);

var t_o_txt_nperiod = instance_create_layer(0, 0, "Text", o_txt);
t_o_txt_nperiod.v_txt_fx_phys = argument[5];
t_o_txt_nperiod.v_txt_fx_colr = argument[6];
if (argument_count >= 8) t_o_txt_nperiod.v_txt_font = argument[7];
scr_txt_set_text(t_o_txt_nperiod, argument[1]);
scr_txt_set_colr(t_o_txt_nperiod, argument[2]);
scr_segment_addtxt(t_segment_wperiod, t_o_txt_nperiod);
var t_o_period = instance_create_layer(0, 0, "Text", o_txt);
scr_txt_set_text(t_o_period, ". ");
scr_txt_set_colr(t_o_period, argument[3]);

if (argument_count >= 5) t_segment_wperiod.v_segment_startnewline = argument[4];

scr_segment_addtxt(t_segment_wperiod, t_o_period);

ds_list_add(argument[0], t_segment_wperiod);