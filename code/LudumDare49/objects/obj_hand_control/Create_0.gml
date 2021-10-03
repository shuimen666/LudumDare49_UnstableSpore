/// @description Insert description here
// You can write your code in this editor
globalvar Hand,Deck;
Hand = new Array();
Deck = new Array();

globalvar DrawCard,ResetCardPosition,FlashCardPosition;
DrawCard = function() {
	if(Deck.size()>0) {
		var ncard = Deck.top();
		Hand.push(ncard);
		Deck.pop();
		ncard.CreateCard(obj_deck_show.x,obj_deck_show.y);
	}
	ResetCardPosition();
}
ResetCardPosition = function() {
	var gap = 32, width = sprite_get_width(spr_card);
	var fx=x,fy=y;
	if(Hand.size()%2==1) fx = x-width/2;
	else fx = x+gap/2;
	fx -= floor(Hand.size()/2)*(width+gap);
	for(var i=0;i<Hand.size();i++) {
		Hand.at(i).Move(fx+i*(width+gap),fy);
	}
}
FlashCardPosition = function() {
	var gap = 32, width = sprite_get_width(spr_card);
	var fx=x,fy=y;
	if(Hand.size()%2==1) fx = x-width/2;
	else fx = x+gap/2;
	fx -= floor(Hand.size()/2)*(width+gap);
	for(var i=0;i<Hand.size();i++) {
		if(Hand.at(i).object!=-1) {
			Hand.at(i).object.x=fx+i*(width+gap);
			Hand.at(i).object.y=fy;
		}
		else Hand.at(i).CreateCard(fx+i*(width+gap),fy);
	}
}

for(var i=0;i<BattleCard.at(i);i++) Deck.push(BattleCard.at(i));
Deck.shuffle();
DrawCard();
DrawCard();
DrawCard();