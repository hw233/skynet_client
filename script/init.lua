local proto = require "proto"
local socketmgr = require "socketmgr"

function init()
	socketmgr.init()
	proto.init()
end

init()
