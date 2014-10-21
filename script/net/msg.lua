require "script.base"
local msg = {}

-- s2c
local REQUEST = {}
msg.REQUEST = REQUEST

function REQUEST.notify(srvname,request)
end

function REQUEST.messagebox(srvname,request)
end

local RESPONSE = {}
msg.RESPONSE = RESPONSE
return msg
