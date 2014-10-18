-- [1,100)
local proto = {}
proto.c2s = [[
login_register 1 {
	request {
		account 0 : string
		passwd 1 : string
		srvname 2 : string
	}
	response {
		# 200 Ok; 201 Account exist;
		result 0 : string
	}
}

login_createrole 2 {
	request {
		roletype 0 : integer
		name 1 : string
	}
	response {
		result 0 : string
	}
}

.roletype {
		id 0 : integer
		name 1 : string
		shape 2 : integer
}

login_login 3 {
	request {
		account 0 : string
		passwd 1 : string
	}
	response {
		result 0 : string
		roles 1 : *roletype
	}
}


login_entergame 4 {
	request {
		roleid 0 : integer
	}
	response {
		result 0 : string
	}
	
}
]]

proto.s2c = [[
]]

return proto
