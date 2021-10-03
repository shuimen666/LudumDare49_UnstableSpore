/// @description Insert description here
// You can write your code in this editor
draw_set_color(c_black);
draw_set_alpha(0.6);
draw_rectangle(0,0,room_width,room_height,0);
draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
if(Language=="en") draw_set_font(Font_showChoose);
else draw_set_font(Font_showChoose_chs);
draw_set_color(c_white);
draw_text(6,6,deckmessage);