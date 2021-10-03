/// @description Insert description here
// You can write your code in this editor
var crow,ccol;
crow = floor((mouse_y-obj_battle_control.y)/sprite_get_height(spr_battlecell));
ccol = floor((mouse_x-obj_battle_control.x)/sprite_get_width(spr_battlecell));
if(!cooldown) {
	if(drawMove)
	{
		if(CellExist(crow,ccol)) {
			if(drawMap[crow][ccol]>0) {
				MoveTo(crow,ccol);
				drawMove = false;
			}
		}
	}
	if(drawAttack)
	{
		if(CellExist(crow,ccol)) {
			if(drawMap[crow][ccol]>0) {
				Attack(crow,ccol);
				drawAttack = false;
			}
		}
	}
	if(drawChoose)
	{
		if(CellExist(crow,ccol)) {
			if(drawMap[crow][ccol]>0) {
				var tmp = new Card({name:"blank"});
				for(var i=0;i<array_length(chooseFuncs);i++)
					tmp.__doFunc(["Make",[crow,ccol],chooseFuncs[i]]);
				drawChoose = false;
			}
		}
	}
}