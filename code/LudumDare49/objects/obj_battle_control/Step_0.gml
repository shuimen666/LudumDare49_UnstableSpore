/// @description Insert description here
// You can write your code in this editor
if(Turn==TURN_STAGE.PLAYER_BEGIN) {
	obj_hero.TurnBegin();
	NextTurn();
}
else if(Turn==TURN_STAGE.PLAYER_END) {
	obj_hero.TurnEnd();
	NextTurn();
}
else if(Turn==TURN_STAGE.ENEMY_SACT) {
	if(firstIn&&WaitOver()) { with(obj_spore) { if(level=="normal") ReadyAct(); } Wait(1*room_speed); firstIn = 0; }
	if(WaitOver()) { NextTurn(); Wait(0.7*room_speed); }
}
else if(Turn==TURN_STAGE.ENEMY_MACT) {
	if(firstIn&&WaitOver()) { with(obj_spore) { if(level=="elite") ReadyAct(); } Wait(1*room_speed); firstIn = 0; }
	if(WaitOver()) { NextTurn(); }
}
else if(Turn==TURN_STAGE.ENEMY_LACT) {
	if(firstIn&&WaitOver()) { with(obj_spore) { if(level=="boss") ReadyAct(); } Wait(1*room_speed); firstIn = 0; }
	if(WaitOver()) { NextTurn(); Wait(0.7*room_speed); }
}