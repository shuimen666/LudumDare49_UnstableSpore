// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function GetX(_row,_col){
	return obj_battle_control.x+_col*sprite_get_width(spr_battlecell);
}
function GetY(_row,_col){
	return obj_battle_control.y+_row*sprite_get_height(spr_battlecell);
}
function NameLanguage(_language,_card)
{
	if(_language=="chs") return _card.chsName;
	else if(_language=="en") return _card.enName;
}