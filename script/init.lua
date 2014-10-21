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
local net = require "script.net"
local proto = require "script.proto"
local socketmgr = require "script.socketmgr"

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
	net.init()
	proto.init()
	socketmgr.init()
	dispatch()
end

init()
