/// @description Insert description here
// You can write your code in this editor
deckmessage = "";
deck = new Array();
init = true;
waiting = false;

function Ensure(_card)
{
	BattleCard.push(_card);
	instance_destroy(obj_showcard);
	instance_destroy();
}