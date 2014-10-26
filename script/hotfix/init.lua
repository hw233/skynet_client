require "script.logger"

local patten = "./?.lua;./?/init.lua"
local ignore_module = {
}

hotfix = {}

function hotfix.hotfix(modname)
	if not package.loaded[modname] then
		logger.log("info","hotfix",string.format("unload module:%s,not need to hotfix",modname))
		return
	end
	if modname:sub(1,6) ~= "script" then
		logger.log("warning","hotfix",string.format("cann't hotfix non-script code,module=%s",modname))
		return
	end
	if ignore_module[modname] then
		return
	end
	local chunk,err
	local errlist = {}
	local name = string.gsub(modname,"%.","/")
	for pat in string.gmatch(patten,"[^;]+") do
		local filename = string.gsub(pat,"?",name)
		chunk,err = loadfile(filename)
		if chunk then
			break
		else
			table.insert(errlist,err)
		end
	end
	if not chunk then
		local msg = string.format("hotfix fail,module=%s reason=%s",modname,table.concat(errlist,"\n"))
		logger.log("error","hotfix",msg)
		error(msg)
		return
	end
	package.loaded[modname] = chunk()
	logger.log("info","hotfix","hotfix " .. modname)
end

return hotfix

