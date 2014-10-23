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
		# 200 Ok; 201 Account exist; 204 Invalid account format; 205 Invalid password format
		result 0 : string
	}
}

.roletype {
		pid 0 : integer
		name 1 : string
		roletype 2 : integer
}

login_createrole 2 {
	request {
		account 0 : string
		roletype 1 : integer
		name 2 : string
	}
	response {
		# 200 Ok; 301 Invalid roletype; 302 Invalid name
		result 0 : string
		newrole 1 : roletype
	}
}



login_login 3 {
	request {
		account 0 : string
		passwd 1 : string
	}
	response {
		# 200 Ok; 202 Account nonexist; 203 Password error
		result 0 : string
		roles 1 : *roletype
	}
}


login_entergame 4 {
	request {
		roleid 0 : integer
	}
	response {
		# 200 Ok
		result 0 : string
	}
	
}
]]

proto.s2c = [[
login_kick 1 {
	request {
		reason 0 : string
	}
}
]]

return proto
