local root = "skynet/"
local cpaths = {
	root .. "luaclib/?.so",
}
local paths = {
	root .. "lualib/?.lua",
	"script/?.lua",
	"script/?/init.lua",
}
package.cpath = package.cpath ..";".. table.concat(cpaths,";")
package.path = package.path .. ";" .. table.concat(paths,";")

require "base"
local proto = require "proto"
local socketmgr = require "socketmgr"

function init()
	print(io.read)	
	proto.init()
	print(io.read)
	socketmgr.init()
	while true do
		local result = socketmgr.dispatch()
		if result == "exit" then
			print("client gameover")
			break
		end
	end
end

init()
