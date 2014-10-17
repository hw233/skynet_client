-- [200,300)
local proto = {}
proto.c2s = [[
]]

proto.s2c = [[
player_resource 200 {
	request {
		gold 0 : integer
	}
}

player_switch = {
	request {
		gm 0 : boolean
	}
}
]]
return proto
