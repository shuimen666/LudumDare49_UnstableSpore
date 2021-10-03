/// @description Insert description here
// You can write your code in this editor
if(init) {
	instance_create_layer(GetX(3,2),GetY(3,2),"Unit",obj_hero);
	if(GameLevel<6) {
		//Elite
		var erow,ecol,pool = new Array();
		for(var i=0;i<7;i++)
			for(var j=0;j<7;j++)
			{
				if(i==3&&j==2) continue;
				if(CellExist(i,j)&&(i-3+j-2>=5)) pool.push([i,j]);
			}
		if(pool.size()==0) {room_restart();exit;}
		else {
			pool.shuffle();
			erow = pool.top()[0];
			ecol = pool.top()[1];
		}
		var ins = instance_create_layer(GetX(erow,ecol),GetY(erow,ecol),"Unit",obj_spore);
		ins.level = "elite";
		//Normal Spore
		pool.clear();
		for(var i=0;i<7;i++)
			for(var j=0;j<7;j++)
			{
				if(i==3&&j==2) continue;
				if(i==erow&&j==ecol) continue;
				if(CellExist(i,j)) pool.push([i,j]);
			}
		if(pool.size()==0) {room_restart();exit;}
		pool.shuffle();
		for(var i=0;i<2+GameLevel;i++) {
			var ins = instance_create_layer(GetX(pool.top()[0],pool.top()[1]),GetY(pool.top()[0],pool.top()[1]),"Unit",obj_spore);
			ins.level = "normal";
			pool.pop();
		}
	}
	else {
		//Boss
		var erow,ecol,pool = new Array();
		for(var i=0;i<7;i++)
			for(var j=0;j<7;j++)
			{
				if(i==3&&j==2) continue;
				if(CellExist(i,j)&&(i-3+j-2>=5)) pool.push([i,j]);
			}
		if(pool.size()==0) {room_restart();exit;}
		else {
			pool.shuffle();
			erow = pool.top()[0];
			ecol = pool.top()[1];
		}
		var ins = instance_create_layer(GetX(erow,ecol),GetY(erow,ecol),"Unit",obj_spore);
		ins.level = "boss";
		//Normal Spore
		pool.clear();
		for(var i=0;i<7;i++)
			for(var j=0;j<7;j++)
			{
				if(i==3&&j==2) continue;
				if(i==erow&&j==ecol) continue;
				if(CellExist(i,j)) pool.push([i,j]);
			}
		if(pool.size()==0) {room_restart();exit;}
		pool.shuffle();
		for(var i=0;i<3+GameLevel;i++) {
			var ins = instance_create_layer(GetX(pool.top()[0],pool.top()[1]),GetY(pool.top()[0],pool.top()[1]),"Unit",obj_spore);
			ins.level = "normal";
			pool.pop();
		}
	}
	init = false;
}