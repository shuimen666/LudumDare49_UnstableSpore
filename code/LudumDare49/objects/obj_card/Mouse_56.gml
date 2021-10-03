/// @description Insert description here
// You can write your code in this editor
if(choosing == 1)
{
	choosing = 0;
	var crow,ccol;
	crow = floor((mouse_y-obj_battle_control.y)/sprite_get_height(spr_battlecell));
	ccol = floor((mouse_x-obj_battle_control.x)/sprite_get_width(spr_battlecell));
	if(obj_hero.able()&&crow>-1&&crow<7&&ccol>-3&&ccol<8) {
		obj_hero.nowact = "card";
		card.DoFunc();
		Hand.erase(card);
		BattleCard.erase(card);
		instance_destroy();
	}
	FlashCardPosition();
}