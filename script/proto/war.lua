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
	}
}

war_heroattack 505 {
	request {
		targetid 0 : integer
	}
}

war_footmanattack 506 {
	request {
		warcardid 0 : integer
		targetid 1 : integer
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
]]

return proto
