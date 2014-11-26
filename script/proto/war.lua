-- [500,600)
local proto = {}
proto.c2s = [[
war_selectcardtable 500 {
	request {
		# fight; arena; entertainment
		type 0 : string
		cardtableid 1 : integer
		
	}
}

war_search_opponent 501 {
	request {
		# fight; arena; entertainment
		type 0 : string
	}
}

war_confirm_handcard 502 {
	request {
		# 战斗卡牌SID列表
		cardsids 0 : *integer
	}
}

war_playcard 503 {
	request {
		cardid 0 : integer
		targetid 1 : integer
	}
}

war_endround 504 {
	request {
		roundcnt 0 : integer
	}
}

war_launchattack 505 {
	request {
		attackerid 0 : integer
		defenserid 1 : integer
	}
}

war_hero_useskill 506 {
	request {
		targetid 0 : integer
	}
}

]]

proto.s2c = [[

.Weapon {
	atk 0 : integer
	validcnt 1 : integer
}

.State {
	freeze 0 : integer
	sneer 1 : integer
}

.Buf {
	addhp 0 : integer
	addatk 1 : integer
	addcrystal 2 : integer
	sethp 3 : integer
	setatk 4 : integer
	setcrystal 5 : integer
}

.CardData {
	cardid 0 : integer
	sid 1 : integer
	hp 2 : integer
	atk 3 : integer
	state 4 : State
	buf 5 : Buf
}


.Hero {
	hp 0 : integer
	atk 1 : integer
	crystal 2 : integer
	empty_crystal 3 : integer
	weapon 4 : Weapon
	state 5 : State
}

war_startwar 500 {
	request {
		warid 0 : integer
	}
}

war_refreshwar 501 {
	request {
		self 0 : Hero
		enemy 1 : Hero
		carddatas 2 : *CardData
	}
}

war_warresult 502 {
	request {
		warid 0 : integer
		result 1 : integer
	}
}
war_beginround 503 {
	request {
		roundcnt 0 : integer
	}
}

war_random_handcard 504 {
	request {
		cardsids 0 : *integer
	}
}

war_matchplayer 505 {
	request {
		pid 0 : integer
		race 1 : integer
		name 2 : string
		lv 3 : integer
		photo 4 : integer
		# 显示的成就列表
		show_achivelist 5 : *integer
		isattacker 6 : boolean
	}
}

.BuffType {
	addmaxhp 0 : integer
	addatk 1 : integer
	setmaxhp 2 : integer
	setatk 3 : integer
}

.HaloType {
	addmaxhp 0 : integer
	addatk 1 : integer
	addcrystalcost 2 : integer
	setcrystalcost 3 : integer
	mincrystalcost 4 : integer
}

.StateType {
	assault 0 : integer
	sneer 1 : integer
	shield 2 : integer
	magic_immune 3 : integer
	freeze 4 : integer
	enrage 5 : boolean
}

.WarCardType {
	id 0 : integer
	maxhp 1 : integer
	atk 2 : integer
	hp 3 : integer
	atkcnt 4 : integer
	leftatkcnt 5 : integer
	state 6 : StateType
}

.WeaponType {
	sid 0 : integer
	usecnt 1 : integer
}


.ArgType {
	id 0 : integer
	pos 1 : integer
	warcard 2 : WarCardType
	attacker 3 : integer
	defenser 4 : integer
	sid 5 : integer
	value 6 : integer
	buff 7 : BuffType
	halo 8 : HaloType
	state 9 : string
	weapon 10 : WeaponType
	targetid 11 : integer
	
}

# addbuff {buff=BuffType}
# delbuff {id=integer}
# addhalo {halo=HaloType}
# delhalo {id=integer}
# setmaxhp {value=integer}
# setatk {value=integer}
# setcrystalcost {value=integer}
# sethp {value=integer}
# silence {pos=integer}
# syncard {warcard=WarCardType}
# delweapon {sid=integer}
# equipweapon {weapon=WeaponType}
# setweaponusecnt {value=integer}
# useskill {id=integer}
# addfootman {pos=integer,warcard=WarCardType}
# delfootman {id=integer}
# playcard {id=integer,pos=integer,targetid=integer}
# footman_attack_footman {id=integer,targetid=integer}
# footman_attack_hero {id=integer,targetid=integer}
# hero_attack_footman {id=integer,targetid=integer}
# hero_attack_hero {id=integer,targetid=integer}
# putinhand {id=integer,sid=integer}
# removefromhand {id=integer}
# addsecret {id=integer}
# delsecret {id=integer}

.CmdType {
	id 0 : integer
	cmd 1 : string
	args 2 : ArgType
}

war_sync 506 {
	request {
		cmds 0 : *CmdType
	}
}
]]

return proto
