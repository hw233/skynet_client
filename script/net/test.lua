require "base"
socketmgr = require "socketmgr"

local test = {}
-- c2s
function test.handshake(srvname)
	pprintf("%s",{
		direction = "c2s",
		srvname = srvname,
		cmd = "test.handshake",
		args = nil,
	})
	socketmgr.send_request(srvname,"test","handshake")
end

function test.get(srvname,args)
	pprintf("%s",{
		direction = "c2s",
		srvname = srvname,
		cmd = "test.get",
		args = args,
	})
	socketmgr.send_request(srvname,"test","get",args)
end

function test.set(srvname,args)
	pprintf("%s",{
		direction = "c2s",
		svrname = srvname,
		cmd = "test.set",
		args = args,
	})
	socketmgr.send_request(srvname,"test","set",args)
end


-- s2c
local REQUEST = {} 
test.REQUEST = REQUEST
function REQUEST.heartbeat(srvname)
end

local RESPONSE = {}
test.RESPONSE = RESPONSE
function RESPONSE.handshake(srvname,args)
end

function RESPONSE.get(srvname,session,args)
end

return test
