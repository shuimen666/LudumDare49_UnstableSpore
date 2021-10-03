/// @description Insert description here
// You can write your code in this editor
for(var i=0;i<7;i++)
	for(var j=0;j<7;j++)
		if(CellExist(i,j)) draw_sprite(spr_battlecell,0,x+j*sprite_get_width(spr_battlecell),y+i*sprite_get_height(spr_battlecell));