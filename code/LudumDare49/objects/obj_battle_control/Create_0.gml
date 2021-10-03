/// @description Insert description here
// You can write your code in this editor
map = [];
globalvar Cells,Position;
Cells = DFSCreateCells(3,3);
/*[
	[1,1,1,1,1,1,1],
	[1,1,1,1,1,1,1],
	[1,1,1,1,1,1,1],
	[1,1,1,1,1,1,1],
	[1,1,1,1,1,1,1],
	[1,1,1,1,1,1,1],
	[1,1,1,1,1,1,1],
];*/
Position = [
	[0,0,0,0,0,0,0],
	[0,0,0,0,0,0,0],
	[0,0,0,0,0,0,0],
	[0,0,0,0,0,0,0],
	[0,0,0,0,0,0,0],
	[0,0,0,0,0,0,0],
	[0,0,0,0,0,0,0],
];
enum TURN_STAGE {
	PLAYER_BEGIN,
	PLAYER_ACT,
	PLAYER_END,
	ENEMY_SACT,
	ENEMY_MACT,
	ENEMY_LACT,
	NUM
};
globalvar Turn;
Turn = TURN_STAGE.PLAYER_BEGIN;
function NextTurn()
{
	Turn++;
	if(Turn==TURN_STAGE.NUM) Turn = TURN_STAGE.PLAYER_BEGIN;
	firstIn = 1;
}
globalvar CellExist,AbleAct,GetPositionMap,GetBlankMap;
CellExist = function(_row,_col) {
	if(_row<0||_row>=7||_col<0||_col>=7) return false;
	if(Cells[_row,_col]==0) return false;
	return true;
}
AbleAct = function() {
	if(Turn==TURN_STAGE.PLAYER_ACT) return true;
	return false;
}
GetPositionMap = function() {
	map = [
		[0,0,0,0,0,0,0],
		[0,0,0,0,0,0,0],
		[0,0,0,0,0,0,0],
		[0,0,0,0,0,0,0],
		[0,0,0,0,0,0,0],
		[0,0,0,0,0,0,0],
		[0,0,0,0,0,0,0]
	];
	with(obj_hero) { other.map[row][col] = 1; }
	with(obj_spore) { if(alive()) other.map[row][col] = 2; }
	return map;
}
GetBlankMap = function(n) {
	if(n==undefined) n=0;
	map = [
		[n,n,n,n,n,n,n],
		[n,n,n,n,n,n,n],
		[n,n,n,n,n,n,n],
		[n,n,n,n,n,n,n],
		[n,n,n,n,n,n,n],
		[n,n,n,n,n,n,n],
		[n,n,n,n,n,n,n]
	];
	return map;
}

enemyAct = -1;
cooldown = false;
firstIn = 1;
init = true;

function WaitOver()
{
	if(obj_battle_control.enemyAct != -1) return false;
	if(cooldown) return false;
	return true;
}
function Wait(_time)
{
	cooldown = true;
	alarm[0] = _time;
}

if(!audio_is_playing(sound_music)) audio_play_sound(sound_music,1,true);
else  audio_resume_sound(sound_music);
