require "script.base"

local player = {}

-- s2c
local REQUEST = {}
player.REQUEST = REQUEST

function REQUEST.heartbeat(srvname,request)
end

function REQUEST.resource(srvname,request)
end

function REQUEST.switch(srvname,request)
end

local RESPONSE = {}
player.RESPONSE = RESPONSE

return player
