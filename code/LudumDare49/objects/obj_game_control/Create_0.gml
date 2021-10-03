/// @description Insert description here
// You can write your code in this editor
globalvar RandomCard,GetCardChoose;
RandomCard = function(num)
{
	var tmp = [];
	RandomPool.shuffle();
	for(var i=0;i<num;i++) {
		array_push(tmp,new Card(RandomPool.at(i)));
	}
	return tmp;
}
GetCardChoose = function(_messageArray)
{
	var ins = instance_create_layer(0,0,"Show",obj_choose_card);
	if(Language=="en") ins.deckmessage = _messageArray[0];
	else if(Language=="chs") ins.deckmessage = _messageArray[1];
	var tmp = RandomCard(3);
	for(var i=0;i<3;i++)
	{
		ins.deck.push(tmp[i]);
	}
}

cooldown = false;
firstIn = 1;

function WaitOver()
{
	if(instance_exists(obj_choose_card)) return false;
	if(cooldown) return false;
	return true;
}
function Wait(_time)
{
	cooldown = true;
	alarm[0] = _time;
}