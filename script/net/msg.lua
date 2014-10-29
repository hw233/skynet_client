require "script.base"
netmsg = netmsg or {}

-- s2c
local REQUEST = {}
netmsg.REQUEST = REQUEST

function REQUEST.notify(srvname,request)
end

function REQUEST.messagebox(srvname,request)
end

local RESPONSE = {}
netmsg.RESPONSE = RESPONSE

return netmsg
