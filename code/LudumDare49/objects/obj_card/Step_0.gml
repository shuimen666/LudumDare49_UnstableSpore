/// @description Insert description here
// You can write your code in this editor
if(card!=undefined) image_index = card.cardType;
if(moving>0)
{
	if(point_distance(x,y,movingx,movingy)<speed) {
		speed = 0;
		x = movingx;
		y = movingy;
		moving = 0;
	}
}
if(choosing>0)
{
	x = mouse_x-choosedx;
	y = mouse_y-choosedy;
}
if(mouse_x>x&&mouse_x<x+sprite_width&&mouse_y>y&&mouse_y<y+sprite_height) seeing = true;
else seeing = false;
if(seeing) {
	if(obj_hero.able())
	{
		obj_hero.seeCard = id;
		if(card.hintMove!=undefined) obj_hero.hintMove = card.hintMove;
		if(card.hintAttack!=undefined) obj_hero.hintAttack = card.hintAttack;
	}
}
else if(obj_hero.seeCard==id) {
	obj_hero.seeCard = -1;
	obj_hero.hintMove = [];
	obj_hero.hintAttack = [];
}