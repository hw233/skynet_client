-- [1,100)
local proto = {}
proto.c2s = [[
test_handshake 1 {
	response {
		msg 0 : string
	}
}

test_get 2 {
	request {
		what 0 : string
	}
	response {
		result 0 : string
	}
}

test_set 3 {
	request {
		what 0 : string
		value 1 : string
	}
}
]]

proto.s2c = [[
test_heartbeat 1 {
}
]]

return proto
