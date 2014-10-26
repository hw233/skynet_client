require "script.base"

net_player = net_player or {}

-- s2c
local REQUEST = {}
net_player.REQUEST = REQUEST

function REQUEST.heartbeat(srvname,request)
end

function REQUEST.resource(srvname,request)
end

function REQUEST.switch(srvname,request)
end

local RESPONSE = {}
net_player.RESPONSE = RESPONSE

return net_player
