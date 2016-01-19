local root = "skynet/"
local cpaths = {
	root .. "luaclib/?.so",
}
local paths = {
	root .. "lualib/?.lua",
	"./?.lua",
	--"./?/init.lua",
}
package.cpath = package.cpath ..";".. table.concat(cpaths,";")
package.path = package.path .. ";" .. table.concat(paths,";")

require "script.base.init"
require "script.net.init"
require "script.proto.init"
require "script.socketmgr"
require "script.logger.init"
require "script.conf.srvlist"

local function dispatch(...)
	local args = {...}
	while true do
		local ok,result
		if args then	
			args = nil
			ok,result = pcall(socketmgr.dispatch,...)
		else
			ok,result = pcall(socketmgr.dispatch)
		end
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

local function init()
	logger.init()
	net.init()
	proto.init()
	socketmgr.init()
	dispatch()
end

init()
