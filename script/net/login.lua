require "script.base"

netlogin = netlogin or {}
-- s2c
local REQUEST = {}
netlogin.REQUEST = REQUEST

function REQUEST.kick(srvname,request)

end

local RESPONSE = {}
netlogin.RESPONSE = RESPONSE

function RESPONSE.register(srvname,request,response)
	local result = assert(response.result)
	print("register",result)
	if result == "200 Ok" then
		
	elseif result == "201 Account exist" then
	end
end

function RESPONSE.login(srvname,request,response)
	local result = assert(response.result)
	print("login",result)
	if result == "200 Ok" then
	elseif result == "202 Account nonexist" then
	elseif result == "203 Password error" then
	end
end

function RESPONSE.createrole(srvname,request,response)
	local result = assert(response.result)
	print("createrole",result)
	if result == "200 Ok" then
		local role = assert(response.newrole)
	elseif result == "301 Invalid roletype" then
	elseif result == "302 Invalid name" then
	end
end


function RESPONSE.entergame(srvname,request,response)
	local result = assert(response.result)
	print("entergame",result)
	if result == "200 Ok" then

	end
end


function netlogin.register(srvname,request)
	sendpackage(srvname,"login","register",request)
end

function netlogin.createrole(srvname,request)
	sendpackage(srvname,"login","createrole",request)
end

function netlogin.login(srvname,request)
	sendpackage(srvname,"login","login",request)
end

function netlogin.entergame(srvname,request)
	sendpackage(srvname,"login","entergame",reqeust)
end

function netlogin.exitgame(srvname,request)
	sendpackage(srvname,"login","entergame",request)
end

return netlogin
