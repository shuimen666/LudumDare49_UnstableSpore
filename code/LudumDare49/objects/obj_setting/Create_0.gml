/// @description Insert description here
// You can write your code in this editor
randomize();
globalvar Language;
Language = "en";

#region 卡池
globalvar CardPool;
CardPool = {
	m_dash: {
		name:"m_dash",
		enName:"Dash",
		chsName:"冲刺",
		effect:[["Move",-1,[[0,0,0,1,0,0,0],
							[0,0,0,1,0,0,0],
							[0,0,0,1,0,0,0],
							[1,1,1,0,1,1,1],
							[0,0,0,1,0,0,0],
							[0,0,0,1,0,0,0],
							[0,0,0,1,0,0,0]]]],
		enEffectDes:"Dash up to 3 in some direction",
		chsEffectDes:"向一个方向冲刺至多3格",
		cardType:0,
		hintMove:[
				[0,0,0,1,0,0,0],
				[0,0,0,1,0,0,0],
				[0,0,0,1,0,0,0],
				[1,1,1,0,1,1,1],
				[0,0,0,1,0,0,0],
				[0,0,0,1,0,0,0],
				[0,0,0,1,0,0,0]],
	},
	m_jump: {
		name:"m_jump",
		enName:"Jump",
		chsName:"跳跃",
		effect:[["Move",-1,[[0,0,1,0,0],
							[0,0,0,0,0],
							[1,0,0,0,1],
							[0,0,0,0,0],
							[0,0,1,0,0]]]],
		enEffectDes:"Jump over 1 in some direction",
		chsEffectDes:"向一个方向跳过1格",
		cardType:0,
		hintMove:[[0,0,1,0,0],
				[0,0,0,0,0],
				[1,0,0,0,1],
				[0,0,0,0,0],
				[0,0,1,0,0]]
	},
	m_repair: {
		name:"m_repair",
		enName:"Repair",
		chsName:"维修",
		effect:[["Get","hp",2]],
		enEffectDes:"Restore 2 shield",
		chsEffectDes:"恢复2点护甲",
		cardType:2,
	},
	m_whirlwind: {
		name:"m_whirlwind",
		enName:"Whirlwind",
		chsName:"旋风斩",
		effect:[["Attack","all",-1,[[0,1,0],
									[1,0,1],
									[0,1,0]]]],
		enEffectDes:"Attack all the spore nearby",
		chsEffectDes:"攻击1格范围内所有孢子",
		cardType:1,
		hintAttack:[[0,1,0],
					[1,0,1],
					[0,1,0]]
	},
	m_shoot: {
		name:"m_shoot",
		enName:"Shoot",
		chsName:"射击",
		effect:[["Attack","one",-1,[[0,0,1,0,0],
									[0,1,0,1,0],
									[1,0,0,0,1],
									[0,1,0,1,0],
									[0,0,1,0,0]]]],
		enEffectDes:"Attack a spore at distance 2",
		chsEffectDes:"攻击2格距离的1个孢子",
		cardType:1,
		hintAttack:[[0,0,1,0,0],
					[0,1,0,1,0],
					[1,0,0,0,1],
					[0,1,0,1,0],
					[0,0,1,0,0]]
	},
	m_shield: {
		name:"m_shield",
		enName:"Shield",
		chsName:"护盾",
		effect:[["Get","shield"]],
		enEffectDes:"Prevent damage this turn",
		chsEffectDes:"本回合不受伤害",
		cardType:2,
	},
	m_barrage: {
		name:"m_barrage",
		enName:"Barrage",
		chsName:"火力覆盖",
		effect:[["Choose",-1,[[0,0,0,1,0,0,0],
							[0,0,1,1,1,0,0],
							[0,1,1,1,1,1,0],
							[1,1,1,0,1,1,1],
							[0,1,1,1,1,1,0],
							[0,0,1,1,1,0,0],
							[0,0,0,1,0,0,0]],[],0,[["Attack",[[0,1,0],
														[1,1,1],
														[0,1,0]]]]]],
		enEffectDes:"Attack a position and nearby in distance 3",
		chsEffectDes:"攻击3格范围内的1格及其临近格",
		cardType:1,
		hintMove:[[0,0,0,1,0,0,0],
				[0,0,1,1,1,0,0],
				[0,1,1,1,1,1,0],
				[1,1,1,0,1,1,1],
				[0,1,1,1,1,1,0],
				[0,0,1,1,1,0,0],
				[0,0,0,1,0,0,0]],
		hintAttack:[[0,1,0],
					[1,1,1],
					[0,1,0]]
	},
	m_planb: {
		name:"m_planb",
		enName:"Plan B",
		chsName:"B计划",
		effect:[["Get","randomCard","Hand"],["Get","randomCard","Hand"]],
		enEffectDes:"Gain 2 random cards which can only be used in this battle",
		chsEffectDes:"获得2张仅可用于本次战斗的卡牌",
		cardType:2,
	},
	m_weaknova: {
		name:"m_weaknova",
		enName:"Weak Nova",
		chsName:"虚弱干扰",
		effect:[["Choose",4,[],[["spore"]],1,[["Set",[[0,1,0],
												[1,1,1],
												[0,1,0]],"weak"]]]],
		enEffectDes:"Weaken a spore and its nearby in distance 4",
		chsEffectDes:"使4格内1个孢子及其临近孢子虚弱",
		cardType:1,
		hintMove:[[0,0,0,0,1,0,0,0,0],
				  [0,0,0,1,1,1,0,0,0],
				  [0,0,1,1,1,1,1,0,0],
				  [0,1,1,1,1,1,1,1,0],
				  [1,1,1,1,0,1,1,1,1],
				  [0,1,1,1,1,1,1,1,0],
				  [0,0,1,1,1,1,1,1,0],
				  [0,0,0,1,1,1,1,0,0],
				  [0,0,0,0,1,0,0,0,0]],
		hintAttack:[[0,1,0],
					[1,1,1],
					[0,1,0]]
	},
	m_sporeintellect: {
		name:"m_sporeintellect",
		enName:"Spore Intellect",
		chsName:"孢子智慧",
		effect:[["Draw"],["Draw"]],
		enEffectDes:"Draw 2 cards",
		chsEffectDes:"抽2张牌",
		cardType:2,
	},
	m_nounstable: {
		name:"m_nounstable",
		enName:"No Unstable",
		chsName:"清除不稳定",
		effect:[["Kill",[[0,1,0],
						[1,0,1],
						[0,1,0]],"angry"]],
		enEffectDes:"Clear all angry spore nearby",
		chsEffectDes:"清除周围的愤怒孢子",
		cardType:1,
		hintAttack:[[0,1,0],
					[1,0,1],
					[0,1,0]]
	},
	m_backup: {
		name:"m_backup",
		enName:"Backup",
		chsName:"后援",
		effect:[["Get","hp",1],["Get","moveRange",1]],
		enEffectDes:"Restore 1 shield. Move 1 farther this turn",
		chsEffectDes:"恢复1点护甲，本回合移动距离+1",
		cardType:2
	},
	m_run: {
		name:"m_run",
		enName:"Run",
		chsName:"疾跑",
		effect:[["Move",2]],
		enEffectDes:"Move up to 2 distance",
		chsEffectDes:"移动至多2距离",
		cardType:0,
		hintMove:[[0,0,1,0,0],
				[0,1,1,1,0],
				[1,1,0,1,1],
				[0,1,1,1,0],
				[0,0,1,0,0]],
	},
	m_energetic: {
		name:"m_energetic",
		enName:"Energetic",
		chsName:"精力充沛",
		effect:[["Get","movable"],["Get","attackable"]],
		enEffectDes:"Refresh movement and attack",
		chsEffectDes:"重置移动和攻击次数",
		cardType:2
	},
	m_ragenova: {
		name:"m_ragenova",
		enName:"Rage Nova",
		chsName:"狂怒震慑",
		effect:[["MakeMove",[[0,0,1,0,0],
							[0,1,1,1,0],
							[1,1,0,1,1],
							[0,1,1,1,0],
							[0,0,1,0,0]]]],
		enEffectDes:"Make spores in 2 distance leave",
		chsEffectDes:"使距离2内的孢子移开",
		cardType:1,
		hintAttack:[[0,0,1,0,0],
					[0,1,1,1,0],
					[1,1,0,1,1],
					[0,1,1,1,0],
					[0,0,1,0,0]],
	},
	m_rightslam: {
		name:"m_rightslam",
		enName:"Right Slam",
		chsName:"右猛击",
		effect:[["Attack","all",-1,[[0,0,0,0,0,0,0],
									[0,0,1,0,1,1,1],
									[0,0,0,0,0,0,0]]]],
		enEffectDes:"Attack spores on the right side",
		chsEffectDes:"攻击右侧孢子",
		cardType:1,
		hintAttack:[[0,0,0,0,0,0,0],
					[0,0,1,0,1,1,1],
					[0,0,0,0,0,0,0]],
	},
	m_downslam: {
		name:"m_downslam",
		enName:"Down Slam",
		chsName:"下猛击",
		effect:[["Attack","all",-1,[[0,0,0],
									[0,0,0],
									[0,1,0],
									[0,0,0],
									[0,1,0],
									[0,1,0],
									[0,1,0]]]],
		enEffectDes:"Attack spores on the down side",
		chsEffectDes:"攻击下侧孢子",
		cardType:1,
		hintAttack:[[0,0,0],
					[0,0,0],
					[0,1,0],
					[0,0,0],
					[0,1,0],
					[0,1,0],
					[0,1,0]],
	},
	m_rushslam: {
		name:"m_rushslam",
		enName:"Rush Slam",
		chsName:"冲刺猛击",
		effect:[["Move",2],["Get","card",{
											name:"m_whirlwind",
											enName:"Whirlwind",
											chsName:"旋风斩",
											effect:[["Attack","all",-1,[[0,1,0],
																		[1,0,1],
																		[0,1,0]]]],
											enEffectDes:"Attack all the spore nearby",
											chsEffectDes:"攻击1格范围内所有孢子",
											cardType:1,
											hintAttack:[[0,1,0],
														[1,0,1],
														[0,1,0]]
										},"Hand"]],
		enEffectDes:"Move up to 2 and gain 'Whirlwind'",
		chsEffectDes:"移动至多2格并获得旋风斩",
		cardType:0,
		hintMove:[[0,0,1,0,0],
				  [0,1,1,1,0],
				  [1,1,0,1,1],
				  [0,1,1,1,0],
				  [0,0,1,0,0]]
	},
	m_relax: {
		name:"m_relax",
		enName:"Relax",
		chsName:"小憩",
		effect:[["Get","hp",1],["Draw"]],
		enEffectDes:"Restore 1 shield and draw a card",
		chsEffectDes:"恢复1点护甲，抽1张牌",
		cardType:2,
	},
}
#endregion

globalvar RandomPool; RandomPool = new Array();
var tmp = variable_struct_get_names(CardPool);
for(var i=0;i<array_length(tmp);i++) {
	RandomPool.push(variable_struct_get(CardPool,tmp[i]));
}

globalvar GameStart; GameStart = false;
globalvar BattleCard; BattleCard = new Array();
globalvar getCard,getMaxCard,GameLevel,Money;
getCard = 0;
getMaxCard = 0;
GameLevel = 0;
Money = 0;

function CreateEffect()
{
	var ins = instance_create_layer(choose(-irandom(100),room_width+irandom(100)),choose(-irandom(100),room_height+irandom(100)),"Effect",obj_title_spore);
	ins.speed = 2+irandom(5);
	ins.direction = point_direction(ins.x,ins.y,room_width/2,room_height/2)-45+irandom(90);
}

alarm[0] = 1;