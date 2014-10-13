require "base"
socketmgr = require "socketmgr"

local test2 = {}

-- c2s
function test2.echo(srvname,args)
	pprintf("%s",{
		direction = "c2s",
		srvname = srvname,
		cmd = "test2.echo",
		args = args,
	})
	socketmgr.send_request(srvname,"test2","echo",args)
end

-- s2c
local REQUEST = {}
test2.REQUEST = REQUEST

local RESPONSE = {}
test2.RESPONSE = RESPONSE
function RESPONSE.echo(srvname,session,args)
end
return test2
