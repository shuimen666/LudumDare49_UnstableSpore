/// @description Insert description here
// You can write your code in this editor
draw_self();
if(drawMove) {
	for(var i=0;i<7;i++)
		for(var j=0;j<7;j++)
			if(drawMap[i][j]>0)
				draw_sprite(spr_choosecell,0,obj_battle_control.x+j*sprite_get_width(spr_battlecell),obj_battle_control.y+i*sprite_get_height(spr_battlecell));
}
if(drawAttack) {
	for(var i=0;i<7;i++)
		for(var j=0;j<7;j++)
			if(drawMap[i][j]>0)
				draw_sprite(spr_choosecell,1,obj_battle_control.x+j*sprite_get_width(spr_battlecell),obj_battle_control.y+i*sprite_get_height(spr_battlecell));
}
if(drawChoose) {
	for(var i=0;i<7;i++)
		for(var j=0;j<7;j++)
			if(drawMap[i][j]>0)
				draw_sprite(spr_choosecell,drawType,obj_battle_control.x+j*sprite_get_width(spr_battlecell),obj_battle_control.y+i*sprite_get_height(spr_battlecell));
}
if(seeCard!=-1) {
	if(hintMove!=undefined&&array_length(hintMove)>0) {
		var lrow = row-floor(array_length(hintMove)/2), lcol = col-floor(array_length(hintMove[0])/2);
		for(var i=0;i<7;i++)
			for(var j=0;j<7;j++) {
				if(!CellExist(i,j)) continue;
				if(i-lrow>=0&&i-lrow<array_length(hintMove)&&j-lcol>=0&&j-lcol<array_length(hintMove[0]))
					if(hintMove[i-lrow][j-lcol]>0)
						draw_sprite(spr_choosecell,0,obj_battle_control.x+j*sprite_get_width(spr_battlecell),obj_battle_control.y+i*sprite_get_height(spr_battlecell));
			}
	}
	if(hintAttack!=undefined&&array_length(hintAttack)>0) {
		var lrow = row-floor(array_length(hintAttack)/2), lcol = col-floor(array_length(hintAttack[0])/2);
		for(var i=0;i<7;i++)
			for(var j=0;j<7;j++) {
				if(!CellExist(i,j)) continue;
				if(i-lrow>=0&&i-lrow<array_length(hintAttack)&&j-lcol>=0&&j-lcol<array_length(hintAttack[0]))
					if(hintAttack[i-lrow][j-lcol]>0)
						draw_sprite(spr_choosecell,1,obj_battle_control.x+j*sprite_get_width(spr_battlecell),obj_battle_control.y+i*sprite_get_height(spr_battlecell));
			}
		
	}
}