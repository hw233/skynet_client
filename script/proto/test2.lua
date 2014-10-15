-- [100,200)
local proto = {}
proto.c2s = [[
test2_echo 100 {
	request {
		what 0 : string
	}
	response {
		result 0 : string
	}
}
]]

proto.s2c = [[
]]

return proto
