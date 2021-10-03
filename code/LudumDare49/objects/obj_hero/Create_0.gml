/// @description Insert description here
// You can write your code in this editor
row = 0;
col = 0;
hp = 3;
maxHp = 3;
moveMap = [];
drawMove = false;
drawAttack = false;
drawChoose = false;
drawType = -1;
chooseFuncs = [];
drawMap = [];
drawPath = [];
walkPath = [];
walking = 0;
cooldown = false;
movable = true;
attackable = true;
nowact = "";
nowcard = undefined;
seeCard = -1;
hintMove = undefined;
hintAttack = undefined;
moveRange = 1;
attackRange = 1;

state = {
	shield: undefined,
}

function set()
{
	row = round(y-obj_battle_control.y)/sprite_get_height(spr_battlecell);
	col = round(x-obj_battle_control.x)/sprite_get_width(spr_battlecell);
}
function able()
{
	if(drawMove||drawAttack) return false;
	if(walking) return false;
	return true;
}
function TurnBegin() {
	audio_play_sound(sound_turnon,1,0);
	movable = true;
	attackable = true;
	DrawCard();
}
function TurnEnd() {
	state = {};
	moveRange = 1;
	attackRange = 1;
}

function MoveCancel() {
	if(nowact=="normalMove") movable = true;
	drawMove = false;
	nowact = "";
}
function AttackCancel() {
	if(nowact=="normalAttack") attackable = true;
	drawAttack = false;
	nowact = "";
}
function NormalMove(_foot) {
	if(!movable) return;
	nowact = "normalMove";
	movable = false;
	TryMove(_foot);
}
function NormalAttack(_foot) {
	if(!attackable) return;
	nowact = "normalAttack";
	attackable = false;
	TryAttack(_foot);
}
function TryMove(_foot,_fixMap)
{
	if(!AbleAct()) return;
	if(_fixMap!=undefined) {
		var crow = floor(array_length(_fixMap)/2), ccol = floor(array_length(_fixMap[0])/2);
		moveMap = GetPositionMap();
		var tmpMap = GetBlankMap(1);
		var lrow = row-crow, lcol = col-ccol;
		for(var i=0;i<7;i++)
			for(var j=0;j<7;j++)
				if(i>=row-crow&&i<=row+crow&&j>=col-ccol&&j<=col+ccol) {
					if(_fixMap[i-lrow][j-lcol]>0) tmpMap[i][j] = 0;
				}
		//合并
		for(var i=0;i<7;i++)
			for(var j=0;j<7;j++)
				if(moveMap[i][j]==0&&tmpMap[i][j]!=0) moveMap[i][j] = 9;
	}
	else {
		moveMap = GetPositionMap();
	}
	drawMap = [];
	drawPath = [];
	drawPath = DFSFindAble(_foot,moveMap,row,col);
	drawMap = DFSClose2Map(drawPath);
	//判空
	var blank = true;
	for(var i=0;i<7;i++)
		for(var j=0;j<7;j++)
			if(drawMap[i][j]!=0) {
				blank = false;
				break;
				break;
			}
	if(!blank) {
		drawMove = true;
		cooldown = true;
		alarm[0] = 0.5*room_speed;
	}
	else MoveCancel();
}
function MoveTo(_row,_col)
{
	if(nowact=="normalMove"||nowact=="normalAttack") CheckElite();
	if(drawMap[_row,_col]==0) return;
	walkPath = [];
	var nrow=_row, ncol=_col;
	while(nrow!=row||ncol!=col) {
		for(var i=0;i<array_length(drawPath);i++) {
			if(drawPath[i][$ "row"]==nrow&&drawPath[i][$ "col"]==ncol) {
				array_insert(walkPath,0,[nrow,ncol]);
				show_debug_message([nrow,ncol]);
				nrow = drawPath[i][$ "parent"][0];
				ncol = drawPath[i][$ "parent"][1];
			}
		}
	}
	walking = 1;
}
function TryAttack(_foot,_fixMap)
{
	if(!AbleAct()) return;
	if(_fixMap!=undefined) {
		var crow = floor(array_length(_fixMap)/2), ccol = floor(array_length(_fixMap[0])/2);
		moveMap = GetBlankMap();
		var lrow = row-crow, lcol = col-ccol;
		for(var i=0;i<7;i++)
			for(var j=0;j<7;j++)
				if(i>=row-crow&&i<=row+crow&&j>=col-ccol&&j<=col+ccol) {
					if(_fixMap[i-lrow][j-lcol]>0) moveMap[i][j] = 1;
				}
	}
	else {
		var map = GetBlankMap();
		map[row][col] = 1;
		moveMap = DFSClose2Map(DFSFindAble(_foot,map,row,col));
	}
	drawMap = GetBlankMap();
	with(obj_spore) { if(alive()&&other.moveMap[row][col]>0) other.drawMap[row][col]=1; }
	//判空
	var blank = true;
	for(var i=0;i<7;i++)
		for(var j=0;j<7;j++)
			if(drawMap[i][j]!=0) {
				blank = false;
				break;
				break;
			}
	if(!blank) {
		drawAttack = true;
		cooldown = true;
		alarm[0] = 0.5*room_speed;
	}
	else AttackCancel();
}
function Attack(_row,_col) {
	if(nowact=="normalMove"||nowact=="normalAttack") CheckElite();
	with(obj_spore) {
		if(row==_row&&col==_col) {
			BeAttacked();
		}
	}
}
function TryChoose(_foot,_fixMap,_cond,_type,_funcArray) {
	if(!AbleAct()) return;
	if(_foot==-1) {
		var crow = floor(array_length(_fixMap)/2), ccol = floor(array_length(_fixMap[0])/2);
		moveMap = GetBlankMap();
		var lrow = row-crow, lcol = col-ccol;
		for(var i=0;i<7;i++)
			for(var j=0;j<7;j++)
				if(i>=row-crow&&i<=row+crow&&j>=col-ccol&&j<=col+ccol) {
					if(_fixMap[i-lrow][j-lcol]>0) moveMap[i][j] = 1;
				}
	}
	else {
		var map = GetBlankMap();
		map[row][col] = 1;
		moveMap = DFSClose2Map(DFSFindAble(_foot,map,row,col));
	}
	//Condition
	for(var i=0;i<array_length(_cond);i++) {
		var _con = _cond[i];
		if(_con[0]=="spore") {
			with(obj_spore) { if(alive()&&other.moveMap[row][col]>0) other.moveMap[row][col] = 99; }
			for(var i=0;i<7;i++)
				for(var j=0;j<7;j++)
					if(moveMap[i][j]!=99) moveMap[i][j]=0;
		}
	}
	drawMap = moveMap;
	//判空
	var blank = true;
	for(var i=0;i<7;i++)
		for(var j=0;j<7;j++)
			if(drawMap[i][j]!=0) {
				blank = false;
				break;
				break;
			}
	if(!blank) {
		drawChoose = true;
		drawType = _type;
		chooseFuncs = _funcArray;
		cooldown = true;
		alarm[0] = 0.5*room_speed;
	}
}
function BeAttacked() {
	if(state[$ "shield"]!=undefined) return;
	audio_play_sound(sound_poison,1,0);
	hp--;
}
function CheckElite() {
	with(obj_spore) {
		if(level=="elite") {
			var n = irandom(2);
			if(n==2) Act();
		}
	}
	CheckBoss();
}
function CheckBoss() {
	with(obj_spore) {
		if(level=="boss") {
			var n = irandom(1);
			if(n==1) Act();
		}
	}
}
function Weaken(_row,_col) {
	with(obj_spore) {
		if(alive()&&row==_row&&col==_col) {
			state="weak";
		}
	}
}
function ClearSpore(_row,_col,_state) {
	with(obj_spore) {
		if(row==_row&&col==_col&&state==_state) {
			DieEffect();
			Die();
			instance_destroy();
		}
	}
}
function MakeMove(_row,_col) {
	with(obj_spore) {
		if(alive()&&row==_row&&col==_col) {
			Move();
		}
	}
}

set();