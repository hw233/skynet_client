require "script.base"
require "script.socketmgr"

nettest = nettest or {}
-- c2s
function nettest.handshake(srvname)
	socketmgr.send_request(srvname,"test","handshake")
end

function nettest.get(srvname,request)
	socketmgr.send_request(srvname,"test","get",request)
end

function nettest.set(srvname,request)
	socketmgr.send_request(srvname,"test","set",request)
end


-- s2c
local REQUEST = {} 
nettest.REQUEST = REQUEST
function REQUEST.heartbeat(srvname)
end

local RESPONSE = {}
nettest.RESPONSE = RESPONSE
function RESPONSE.handshake(srvname,request,response)
end

function RESPONSE.get(srvname,request,response)
end

return nettest
