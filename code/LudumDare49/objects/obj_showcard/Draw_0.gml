/// @description Insert description here
// You can write your code in this editor
draw_self();
if(card!=undefined)
{
//Name
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_color(c_white);
	if(Language=="en") draw_set_font(Font_cardName_en);
	else if(Language=="chs") draw_set_font(Font_cardName_chs);
	draw_text(x+sprite_width/2,y+36,NameLanguage(Language,card));
//Des
	var des;
	if(Language=="en") des = card.enEffectDes;
	else if(Language=="chs") des = card.chsEffectDes;
	draw_set_color(c_black);
	var maxW = sprite_get_width(spr_card)-14*2;
	var str = "", maxH = 0;
	//计算长度
	maxH += string_height(MultipleRowString(des,maxW));
	draw_text(x+sprite_width/2,y+146,MultipleRowString(des,maxW));
}