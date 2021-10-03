/// @description Insert description here
// You can write your code in this editor
if(walking>0)
{
	if(point_distance(x,y,GetX(walkPath[0][0],walkPath[0][1]),GetY(walkPath[0][0],walkPath[0][1]))<speed) {
		speed = 0;
		x = GetX(walkPath[0][0],walkPath[0][1]);
		y = GetY(walkPath[0][0],walkPath[0][1]);
		row = walkPath[0][0];
		col = walkPath[0][1];
		array_delete(walkPath,0,1);
		if(array_length(walkPath)==0) {
			speed = 0;
			walking = 0;
		}
	}
	else {
		speed = 4;
		direction = point_direction(x,y,GetX(walkPath[0][0],walkPath[0][1]),GetY(walkPath[0][0],walkPath[0][1]));	
	}
}
if(!able()||(seeCard!=-1&&!instance_exists(seeCard))) {
	seeCard = -1;
	hintMove = undefined;
	hintAttack = undefined;
}
if(hp<=0) room_goto(Room_end);