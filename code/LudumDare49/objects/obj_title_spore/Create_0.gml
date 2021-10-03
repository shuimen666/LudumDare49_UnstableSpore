/// @description Insert description here
// You can write your code in this editor
sprite_index = choose(spr_spore,spr_spore_elite,spr_spore_boss);
image_index = irandom(sprite_get_number(sprite_index)-1);
anSpeed = irandom(8)+2;
image_speed = 0;
step = 0;