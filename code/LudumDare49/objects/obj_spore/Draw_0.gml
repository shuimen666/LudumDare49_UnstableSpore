/// @description Insert description here
// You can write your code in this editor
draw_sprite_ext(sprite_index,image_index,x+32,y+32,image_xscale,image_yscale,image_angle,c_white,image_alpha);

if(level=="elite")
{
	draw_set_color(c_red)
	draw_text(x,y+63,string(hp));
}
if(level=="boss")
{
	draw_set_color(c_red)
	draw_text(x,y+63,string(hp));
}