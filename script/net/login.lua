require "script.base"

net_login = net_login or {}
-- s2c
local REQUEST = {}
net_login.REQUEST = REQUEST

function REQUEST.kick(srvname,request)

end

local RESPONSE = {}
net_login.RESPONSE = RESPONSE

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


function net_login.register(srvname,request)
	sendpackage(srvname,"login","register",request)
end

function net_login.createrole(srvname,request)
	sendpackage(srvname,"login","createrole",request)
end

function net_login.login(srvname,request)
	sendpackage(srvname,"login","login",request)
end

function net_login.entergame(srvname,request)
	sendpackage(srvname,"login","entergame",reqeust)
	print ">>>>>>>>>>>entergame"
end

return net_login
