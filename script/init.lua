local root = "skynet/"
local cpaths = {
	root .. "luaclib/?.so",
}
local paths = {
	root .. "lualib/?.lua",
	"./?.lua",
	"./?/init.lua",
}
package.cpath = package.cpath ..";".. table.concat(cpaths,";")
package.path = package.path .. ";" .. table.concat(paths,";")

require "script.base"
require "script.net"
require "script.proto"
require "script.socketmgr"
require "script.logger"
require "script.player"

local function dispatch()
	while true do
		local ok,result = pcall(socketmgr.dispatch)
		if ok then
			if result == "exit" then
				print("client gameover")
				break
			end
		else
			print(result)
		end
		
	end
end

function init()
	logger.init()
	net.init()
	proto.init()
	socketmgr.init()
	getplayer() -- create a player
	dispatch()
end

init()
