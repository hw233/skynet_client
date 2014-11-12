require "script.base"
require "script.socketmgr"

netwar = netwar or {}
-- c2s


-- s2c
local REQUEST = {} 
netwar.REQUEST = REQUEST
function REQUEST.startwar(srvname,request)

end

function REQUEST.refreshwar(srvname,request)
end

function REQUEST.warresult(srvname,request)
end

function REQUEST.beginround(srvname,request)
end

function REQUEST.matchplayer(srvname,request)
end

function REQUEST.random_handcard(srvname,request)
end

local RESPONSE = {}
netwar.RESPONSE = RESPONSE

return netwar
