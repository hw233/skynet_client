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

local function usage()
	print([[
		usage: lua script/init.lua [script|-f script_file]
	]])
end

local function init(...)
	local args = {...}
	logger.init()
	net.init()
	proto.init()
	socketmgr.init()
	dispatch()
	if #args == 0 then
	elseif #args >= 1 then
		if args[1] == "-f" then -- script file
			local script_file = args[2]
			local func = loadfile(script_file)
			if func then
				func(select(3,...))
			else
				usage()
			end
		else					-- script
			local script = args[1]
			local func = load(script)
			if func then
				func(select(2,...))
			else
				usage()
			end
		end
	else
		usage()
	end
end

init(...)
