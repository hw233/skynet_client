require "script.base"

netplayer = netplayer or {}

-- s2c
local REQUEST = {}
netplayer.REQUEST = REQUEST

function REQUEST.heartbeat(srvname,request)
end

function REQUEST.resource(srvname,request)
end

function REQUEST.switch(srvname,request)
end

local RESPONSE = {}
netplayer.RESPONSE = RESPONSE

return netplayer
