require "script.base"
require "script.socketmgr"

net_test = net_test or {}
-- c2s
function net_test.handshake(srvname)
	socketmgr.send_request(srvname,"test","handshake")
end

function net_test.get(srvname,request)
	socketmgr.send_request(srvname,"test","get",request)
end

function net_test.set(srvname,request)
	socketmgr.send_request(srvname,"test","set",request)
end


-- s2c
local REQUEST = {} 
net_test.REQUEST = REQUEST
function REQUEST.heartbeat(srvname)
end

local RESPONSE = {}
net_test.RESPONSE = RESPONSE
function RESPONSE.handshake(srvname,request,response)
end

function RESPONSE.get(srvname,request,response)
end

return net_test
