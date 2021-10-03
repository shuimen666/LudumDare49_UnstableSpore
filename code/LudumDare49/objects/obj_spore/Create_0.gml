/// @description Insert description here
// You can write your code in this editor
row = 0;
col = 0;
hp = 1;
maxHp = 1;
state = "normal";
reborning = 0;
readyAct = false;
walking = 0;
walkTarget = [];
level = "normal"; //elite boss
init = true;
check = 0;
image_speed = 0;

function set()
{
	row = round(y-obj_battle_control.y)/sprite_get_height(spr_battlecell);
	col = round(x-obj_battle_control.x)/sprite_get_width(spr_battlecell);
}

set();

function alive()
{
	if(state=="reborn") return false;
	return true;
}
function StateChange() {
	if(state=="normal") {
		if(irandom(1)) state="angry";
	}
	else if(state=="angry") {
		if(irandom(1)) state="weak";
		if(level!="normal") state="normal";
	}
	else if(state=="weak") {
		if(irandom(1)) state="normal";
		if(level!="normal") state="normal";
	}
	else if(state=="reborn") {
		var map = GetPositionMap();
		if(map[row][col]==0&&irandom(3)<=reborning) {
			reborning = 0;
			state=choose("normal","angry","weak");
			SummonEffect(x,y);
		}
	}
	
}
function ReadyAct()
{
	if(!alive()) { StateChange(); return;}
	readyAct = true;
}
function Wait4Act() {
	if(readyAct&&obj_battle_control.enemyAct==-1) {
		obj_battle_control.enemyAct = id;
		readyAct = false;
		Act();
	}
}
function FinishAct() {
	if(obj_battle_control.enemyAct==id) obj_battle_control.enemyAct = -1;
	StateChange();
}
function Act()
{
	if(level=="normal") {
		var n = irandom(3);
		switch(n)
		{
			case 0: Stay(); break;
			case 1:
			case 2: Move(); break;
			case 3: Duplicate(); break;
		}
	} else if(level=="elite") {
		var n = irandom(4);
		switch(n)
		{
			case 0: 
			case 1: Stay(); break;
			case 2: 
			case 3: Move(); break;
			case 4: Summon(); break;
		}
	} else if(level=="boss") {
		var n = irandom(4);
		switch(n)
		{
			case 0: Stay(); break;
			case 1:
			case 2: 
			case 3: Move(); break;
			case 4: Summon(); break;
		}
	}
	
}
function Stay() {
	alarm[0] = 0.7*room_speed;
}
function Move()
{
	var map = GetPositionMap();
	var pool = [];
	if(CellExist(row-1,col)&&map[row-1,col]==0) array_push(pool,[row-1,col]);
	if(CellExist(row+1,col)&&map[row+1,col]==0) array_push(pool,[row+1,col]);
	if(CellExist(row,col-1)&&map[row,col-1]==0) array_push(pool,[row,col-1]);
	if(CellExist(row,col+1)&&map[row,col+1]==0) array_push(pool,[row,col+1]);
	if(array_length(pool)==0) { alarm[0] = 0.85*room_speed; return; }
	walking = 1;
	walkTarget = pool[irandom(array_length(pool)-1)];
	row = walkTarget[0];
	col = walkTarget[1];
	speed = 4;
	direction = point_direction(x,y,GetX(walkTarget[0],walkTarget[1]),GetY(walkTarget[0],walkTarget[1]));
	audio_play_sound(sound_move,1,0);
}
function Duplicate()
{
	var map = GetPositionMap();
	var pool = [];
	if(CellExist(row-1,col)&&map[row-1,col]==0) array_push(pool,[row-1,col]);
	if(CellExist(row+1,col)&&map[row+1,col]==0) array_push(pool,[row+1,col]);
	if(CellExist(row,col-1)&&map[row,col-1]==0) array_push(pool,[row,col-1]);
	if(CellExist(row,col+1)&&map[row,col+1]==0) array_push(pool,[row,col+1]);
	if(array_length(pool)==0) { alarm[0] = 0.85*room_speed; return; }
	var tmp = pool[irandom(array_length(pool)-1)];
	var ins = instance_create_layer(GetX(row,col),GetY(row,col),"Unit",obj_spore);
	ins.row = tmp[0];
	ins.col = tmp[1];
	ins.walking = 1;
	ins.walkTarget = tmp;
	ins.speed = 4;
	ins.direction = point_direction(x,y,GetX(tmp[0],tmp[1]),GetY(tmp[0],tmp[1]));
	alarm[0] = 0.85*room_speed;
	audio_play_sound(sound_summon,1,0);
}
function Summon()
{
	var map = GetPositionMap();
	var pool = [];
	if(CellExist(row-1,col)&&map[row-1,col]==0) array_push(pool,[row-1,col]);
	if(CellExist(row+1,col)&&map[row+1,col]==0) array_push(pool,[row+1,col]);
	if(CellExist(row,col-1)&&map[row,col-1]==0) array_push(pool,[row,col-1]);
	if(CellExist(row,col+1)&&map[row,col+1]==0) array_push(pool,[row,col+1]);
	if(CellExist(row-1,col-1)&&map[row-1,col-1]==0) array_push(pool,[row-1,col-1]);
	if(CellExist(row+1,col-1)&&map[row+1,col-1]==0) array_push(pool,[row+1,col-1]);
	if(CellExist(row-1,col+1)&&map[row-1,col+1]==0) array_push(pool,[row-1,col+1]);
	if(CellExist(row+1,col+1)&&map[row+1,col+1]==0) array_push(pool,[row+1,col+1]);
	if(array_length(pool)==0) { alarm[0] = 0.85*room_speed; return; }
	var tmp = pool[irandom(array_length(pool)-1)];
	/*
	var ins = instance_create_layer(GetX(row,col),GetY(row,col),"Unit",obj_spore);
	ins.row = tmp[0];
	ins.col = tmp[1];
	ins.walking = 1;
	ins.walkTarget = tmp;
	ins.speed = 4;
	ins.direction = point_direction(x,y,GetX(tmp[0],tmp[1]),GetY(tmp[0],tmp[1]));
	*/
	var ins = instance_create_layer(GetX(tmp[0],tmp[1]),GetY(tmp[0],tmp[1]),"Unit",obj_spore);
	ins.row = tmp[0];
	ins.col = tmp[1];
	SummonEffect(GetX(tmp[0],tmp[1]),GetY(tmp[0],tmp[1]));
	alarm[0] = 0.85*room_speed;
}
function BeAttacked()
{
	if(state=="normal") {
		DieEffect();
		hp--;
	}
	else if(state=="angry") {
		DieEffect();
		for(var i=0;i<4;i++) {
			var ins = instance_create_layer(x,y,"Bullet",obj_poison);
			ins.speed = 3;
			ins.direction = i*90;
		}
		with(obj_hero) {
			if(row+1==other.row&&col==other.col) BeAttacked();
			if(row-1==other.row&&col==other.col) BeAttacked();
			if(row==other.row&&col-1==other.col) BeAttacked();
			if(row==other.row&&col+1==other.col) BeAttacked();
		}
		hp--;
	}
	else if(state=="weak") {
		DieEffect();
		hp--;
	}
}
function DieEffect()
{
	for(var i=16;i<=48;i+=4)
		for(var j=16;j<=48;j+=4)
		{
			var ins = instance_create_layer(x+i,y+j,"Bullet",obj_spore_die);
			ins.speed = 0.2+random(1);
			ins.direction = irandom(359);
		}
}
function SummonEffect(_x,_y)
{
	audio_play_sound(sound_summon,1,0);
	for(var i=0;i<=64;i+=4)
		for(var j=0;j<=64;j+=4)
		{
			if(i>=16&&i<=48&&j>=16&&j<=48) continue;
			var ins = instance_create_layer(_x+i,_y+j,"Bullet",obj_spore_die);
			ins.speed = 0.2+random(1);
			ins.direction = point_direction(_x+i,_y+j,_x+32,_y+32);
		}
}
function Die()
{
	Money++;
	if(level=="elite") {
		check = 1;
		with(obj_spore)
		{
			if(id!=other.id&&(level=="elite"||level=="boss")) {
				other.check = 0;
			}
		}
		if(check==1) {
			getCard = 3;
			getMaxCard = 3;
			GameLevel++;
			room_goto(Room_game);
			audio_pause_sound(sound_music);
		}
	}
	else if(level=="boss") {
		audio_pause_sound(sound_music);
		room_goto(Room_end);
	}
}