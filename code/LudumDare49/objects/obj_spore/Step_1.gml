/// @description Insert description here
// You can write your code in this editor
if(init) {
	if(level=="elite") { hp = 2; maxHp = 2; }
	else if(level=="boss") { hp = 4; maxHp = 4; }
	image_angle = irandom(359);
	state=choose("normal","angry","weak");
	init = false;
}