require "script.base"
socketmgr = require "script.socketmgr"

local test = {}
-- c2s
function test.handshake(srvname)
	socketmgr.send_request(srvname,"test","handshake")
end

function test.get(srvname,request)
	socketmgr.send_request(srvname,"test","get",request)
end

function test.set(srvname,request)
	socketmgr.send_request(srvname,"test","set",request)
end


-- s2c
local REQUEST = {} 
test.REQUEST = REQUEST
function REQUEST.heartbeat(srvname)
end

local RESPONSE = {}
test.RESPONSE = RESPONSE
function RESPONSE.handshake(srvname,request,response)
end

function RESPONSE.get(srvname,request,response)
end

return test
