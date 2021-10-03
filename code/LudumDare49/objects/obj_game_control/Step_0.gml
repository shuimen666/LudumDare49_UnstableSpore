/// @description Insert description here
// You can write your code in this editor
if(GameStart) {
	BattleCard.clear();
	getCard = 4;
	getMaxCard = 4;
	GameLevel = 1;
	Money = 0;
	GameStart = false;
}
if(getCard>0)
{
	if(WaitOver()) {
		GetCardChoose(["Choose a card to your deck ("+string(getMaxCard-getCard+1)+"/"+string(getMaxCard)+")","选择一张牌加入牌库 ("+string(getMaxCard-getCard+1)+"/"+string(getMaxCard)+")"]);
		getCard--;
	}
}
if(Money>=3)
{
	if(WaitOver()) {
		GetCardChoose(["Choose a card to your deck ("+string(Money)+" / per 3 cores of spore)","选择一张牌加入牌库 ("+string(Money)+" / 每3个孢子核心)"]);
		Money-=3;
	}
}
if(WaitOver())
{
	room_goto(Room_battle);
}