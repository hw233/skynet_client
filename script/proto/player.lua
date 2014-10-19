-- [200,300)
local proto = {}
proto.c2s = [[
]]

proto.s2c = [[
player_heartbeat 200 {
	request {
		msg 0 : string
	}
}

player_resource 201 {
	request {
		gold 0 : integer
	}
}

player_switch 202 {
	request {
		gm 0 : boolean
	}
}


]]

return proto
