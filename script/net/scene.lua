require "script.base"
require "script.socketmgr"

netscene = netscene or {}
-- c2s

-- s2c
local REQUEST = {} 
netscene.REQUEST = REQUEST


local RESPONSE = {}
netscene.RESPONSE = RESPONSE

return netscene
