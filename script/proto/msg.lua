-- [100,200)
local proto = {}
proto.c2s = [[

]]

proto.s2c = [[
msg_notify 100 {
	request {
		msg 0 : string
	}
}

msg_messagebox 101 {
	request {
		title 0 : string
		content 1 : string
		button 2 : string
	}
}

]]

return proto
