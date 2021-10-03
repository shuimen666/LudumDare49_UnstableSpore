// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function Card(_name,_effect) constructor
{
	name = "";
	enName = "";
	chsName = "";
	effect = [];
	enEffectDes = "";
	chsEffectDes = "";
	cardType = 0;
	hintMove = [];
	hintAttack = [];
	
	object = -1;
	function set(_name,_effect) {
		if(_effect!=undefined) {
			name = _name; effect = _effect;
		} else {
			name = _name[$ "name"];
			effect = _name[$ "effect"];
			enName = _name[$ "enName"];
			chsName = _name[$ "chsName"];
			enEffectDes = _name[$ "enEffectDes"];
			chsEffectDes = _name[$ "chsEffectDes"];
			cardType = _name[$ "cardType"];
			hintMove =  _name[$ "hintMove"];
			hintAttack =  _name[$ "hintAttack"];
		}
	}
	function CreateCard(_x,_y) {
		if(object!=-1) instance_destroy(object);
		object = instance_create_layer(_x,_y,"Card",obj_card);
		object.card = self;
	}
	function Move(_x,_y) {
		if(object==-1) CreateCard(_x,_y);
		object.moving = 1;
		object.movingx = _x;
		object.movingy = _y;
		if(point_distance(object.x,object.y,_x,_y)>=10) {
			object.speed = 10;
			object.direction = point_direction(object.x,object.y,_x,_y);
		}
	}
	function DoFunc() {
		obj_hero.CheckBoss();
		for(var i=0;i<array_length(effect);i++) {
			__doFunc(effect[i]);
		}
	}
	function __doFunc(_func) {
		var funcType = _func[0];
		if(funcType=="Move") {
			if(_func[1]!=-1) obj_hero.TryMove(_func[1]);
			else obj_hero.TryMove(_func[1],_func[2]);
		}
		else if(funcType=="Draw") DrawCard();
		else if(funcType=="Get") {
			if(_func[1]=="hp") obj_hero.hp = (obj_hero.hp+_func[2]>obj_hero.maxHp)?obj_hero.maxHp:obj_hero.hp+_func[2];
			else if(_func[1]=="shield") obj_hero.state[$ "shield"] = true;
			else if(_func[1]=="moveRange") obj_hero.moveRange+=_func[2];
			else if(_func[1]=="attackRange") obj_hero.attackRange+=_func[2];
			else if(_func[1]=="movable") obj_hero.movable=true;
			else if(_func[1]=="attackable") obj_hero.attackable=true;
			else if(_func[1]=="randomCard") {
				var tmpCard = RandomCard(1)[0];
				if(_func[2]=="Hand") Hand.push(tmpCard);
				else if(_func[2]=="Deck") Deck.push(tmpCard);
			}
			else if(_func[1]=="card") {
				var tmpCard = new Card(_func[2]);
				if(_func[3]=="Hand") Hand.push(tmpCard);
				else if(_func[3]=="Deck") Deck.push(tmpCard);
			}
		}
		else if(funcType=="Attack") {
			var atType = _func[1];
			if(atType=="all") {
				var map;
				if(_func[2]==-1) {
					map = GetBlankMap();
					var fix = _func[3];
					var lrow = obj_hero.row-floor(array_length(fix)/2), lcol = obj_hero.col-floor(array_length(fix[0])/2);
					for(var i=0;i<7;i++)
						for(var j=0;j<7;j++) {
							if(!CellExist(i,j)) continue;
							if(i-lrow>=0&&i-lrow<array_length(fix)&&j-lcol>=0&&j-lcol<array_length(fix[0]))
								if(fix[i-lrow][j-lcol]>0) map[i][j] = 9;
						}
				}
				else {
					var tmp = GetBlankMap();
					tmp[row][col] = 1;
					map = DFSClose2Map(DFSFindAble(_func[2],tmp,row,col));
				}
				for(var i=0;i<7;i++)
					for(var j=0;j<7;j++)
						if(map[i][j]>0) obj_hero.Attack(i,j);
			} else if(atType=="one") {
				if(_func[2]!=-1) obj_hero.TryAttack(_func[2]);
				else obj_hero.TryAttack(_func[2],_func[3]);
			}
		}
		else if(funcType=="Choose") {
			//TryChoose(_foot,_fixmap,_cond,_type,_funcArray)
			obj_hero.TryChoose(_func[1],_func[2],_func[3],_func[4],_func[5]);
		}
		else if(funcType=="Make") {
			var pos = _func[1], sfunc = _func[2];
			if(sfunc[0]=="Attack") {
				var map;
				map = GetBlankMap();
				var fix = sfunc[1];
				var lrow = pos[0]-floor(array_length(fix)/2), lcol = pos[1]-floor(array_length(fix[0])/2);
				for(var i=0;i<7;i++)
					for(var j=0;j<7;j++) {
						if(!CellExist(i,j)) continue;
						if(i-lrow>=0&&i-lrow<array_length(fix)&&j-lcol>=0&&j-lcol<array_length(fix[0]))
							if(fix[i-lrow][j-lcol]>0) map[i][j] = 9;
					}
				for(var i=0;i<7;i++)
					for(var j=0;j<7;j++)
						if(map[i][j]>0) obj_hero.Attack(i,j);
			}
			else if(sfunc[0]=="Set") {
				var map;
				map = GetBlankMap();
				var fix = sfunc[1];
				var lrow = pos[0]-floor(array_length(fix)/2), lcol = pos[1]-floor(array_length(fix[0])/2);
				for(var i=0;i<7;i++)
					for(var j=0;j<7;j++) {
						if(!CellExist(i,j)) continue;
						if(i-lrow>=0&&i-lrow<array_length(fix)&&j-lcol>=0&&j-lcol<array_length(fix[0]))
							if(fix[i-lrow][j-lcol]>0) map[i][j] = 9;
					}
				for(var i=0;i<7;i++)
					for(var j=0;j<7;j++)
						if(map[i][j]>0) {
							if(sfunc[2]=="weak") obj_hero.Weaken(i,j);
						}
			}
		}
		else if(funcType=="Kill")
		{
			var map;
				map = GetBlankMap();
				var fix = _func[1];
				var lrow = obj_hero.row-floor(array_length(fix)/2), lcol = obj_hero.col-floor(array_length(fix[0])/2);
				for(var i=0;i<7;i++)
					for(var j=0;j<7;j++) {
						if(!CellExist(i,j)) continue;
						if(i-lrow>=0&&i-lrow<array_length(fix)&&j-lcol>=0&&j-lcol<array_length(fix[0]))
							if(fix[i-lrow][j-lcol]>0) map[i][j] = 9;
					}
				for(var i=0;i<7;i++)
					for(var j=0;j<7;j++)
						if(map[i][j]>0) obj_hero.ClearSpore(i,j,_func[2]);
		}
		else if(funcType=="MakeMove")
		{
			var map;
				map = GetBlankMap();
				var fix = _func[1];
				var lrow = obj_hero.row-floor(array_length(fix)/2), lcol = obj_hero.col-floor(array_length(fix[0])/2);
				for(var i=0;i<7;i++)
					for(var j=0;j<7;j++) {
						if(!CellExist(i,j)) continue;
						if(i-lrow>=0&&i-lrow<array_length(fix)&&j-lcol>=0&&j-lcol<array_length(fix[0]))
							if(fix[i-lrow][j-lcol]>0) map[i][j] = 9;
					}
				for(var i=0;i<7;i++)
					for(var j=0;j<7;j++)
						if(map[i][j]>0) obj_hero.MakeMove(i,j);
		}
	}
	
	//Constructor
	set(_name,_effect);
}