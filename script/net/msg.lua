require "script.base"
net_msg = net_msg or {}

-- s2c
local REQUEST = {}
net_msg.REQUEST = REQUEST

function REQUEST.notify(srvname,request)
end

function REQUEST.messagebox(srvname,request)
end

local RESPONSE = {}
net_msg.RESPONSE = RESPONSE

return net_msg
