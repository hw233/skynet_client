require "script.base"
require "script.socketmgr"

netteam = netteam or {}
-- c2s

-- s2c
local REQUEST = {} 
netteam.REQUEST = REQUEST


local RESPONSE = {}
netteam.RESPONSE = RESPONSE

return netteam
