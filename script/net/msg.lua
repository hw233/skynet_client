require "script.base"
netmsg = netmsg or {}

-- c2s
function netmsg.onmessagebox(srvname,request)
	socketmgr.send_request(srvname,"msg","onmessagebox",request)
end

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
