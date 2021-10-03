/// @description Insert description here
// You can write your code in this editor
if(level=="normal") sprite_index = spr_spore;
else if(level=="elite") sprite_index = spr_spore_elite;
else if(level=="boss") sprite_index = spr_spore_boss;
if(walking>0)
{
	if(point_distance(x,y,GetX(walkTarget[0],walkTarget[1]),GetY(walkTarget[0],walkTarget[1]))<speed) {
		speed = 0;
		x = GetX(walkTarget[0],walkTarget[1]);
		y = GetY(walkTarget[0],walkTarget[1]);
		walking = 0;
		FinishAct();
	}
}
if(readyAct) Wait4Act();
if(state=="normal") image_index = 0;
else if(state=="angry") image_index = 1;
else if(state=="weak") image_index = 2;
else if(state=="reborn") image_index = 3;
if(hp<=0) {
	if(state=="normal") {
		state="reborn";
		hp = 1;
	}
	else instance_destroy();
	Die();
}