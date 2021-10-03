/// @description Insert description here
// You can write your code in this editor
if(init) {
	var gap = 64;
	var ox,oy = room_height/2 - sprite_get_height(spr_card)/2;
	if(deck.size()%2==1) ox = room_width/2 - sprite_get_width(spr_card)/2;
	else ox = room_width/2 - gap/2;
	ox -= floor(deck.size()/2) * (sprite_get_width(spr_card)+gap);
	for(var i=0;i<3;i++)
	{
		var ins = instance_create_layer(ox+i*(sprite_get_width(spr_card)+gap),oy,"Card",obj_showcard);
		ins.card = deck.at(i);
		ins.source = id;
	}
	waiting = true;
	init = false;
}