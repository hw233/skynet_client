package.path = "skynet/lualib/?.lua;./?.lua;./?/init.lua"
package.cpath = "skynet/luaclib/?.so"

local socket = require "clientsocket"
local net = require "script.base"
require "script.conf.srvlist"
local socketmgr = require "script.socketmgr"

function test(srvname,account,passwd)
	function onlogin(srvname,request,response)
		local result = assert(response.result)	
		pprintf("login:%s,roles:%s",result,response.roles)
		if result == "202 Account nonexist" then
			sendpackage(srvname,"login","register",{
				account = account,
				passwd = passwd,
				srvname = srvname,
			},onregister)
		elseif result == "200 Ok" then
			local roles = assert(response.roles)
			if #roles == 0 then
				sendpackage(srvname,"login","createrole",{
					account = account,
					roletype = 1001,
					name = account,
				},oncreaterole)
			else
				local role = assert(roles[1],"no role")
				sendpackage(srvname,"login","entergame",{
					roleid = role.id,	
				})
			end
			
		end
	end

	function onregister(srvname,request,response)
		local result = assert(response.result)
		print("register:",result)
		if result == "200 Ok" then
			sendpackage(srvname,"login","createrole",{
				account = account,
				roletype = 1001,
				name = account,
			},oncreaterole)
		end
	end

	function oncreaterole(srvname,request,response)
		local result = assert(response.result)
		print("createrole:",result) 
		if result == "200 Ok" then
			sendpackage(srvname,"login","login",{
				account = account,
				passwd = passwd,
				srvname = srvname,
			},onlogin)
		end
	end

	function onentergame(srvname,request,response)
		local result = assert(response.result)
		print("entergame:",result)
	end
	

	sendpackage(srvname,"login","login",{
		account = account,
		passwd = passwd,
	},onlogin)
end

return test
