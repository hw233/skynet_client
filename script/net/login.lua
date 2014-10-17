require "base"

local login = {}
-- s2c
local REQUEST = {}
login.REQUEST = REQUEST

local RESPONSE = {}
login.RESPONSE = RESPONSE

function RESPONSE.register(srvname,session,args)
	local result = assert(args.result)
	print("register",result)
	if result == "200 Ok" then
		
	elseif result == "201 Account exist" then
	end
end

function RESPONSE.login(srvname,session,args)
	local result = assert(args.result)
	print("login",result)
	if result == "200 Ok" then
	elseif result == "202 Account nonexist" then
	elseif result == "203 Password error" then
	end
end

function RESPONSE.createrole(srvname,session,args)
	local result = assert(args.result)
	print("createrole",result)
	if result == "200 Ok" then
	elseif result == "301 Invalid roletype" then
	elseif result == "302 Invalid name" then
	end
end


function RESPONSE.entergame(srvname,session,args)
	local result = assert(args.result)
	print("entergame",result)
	if result == "200 Ok" then

	end
end


function login.register(srvname,args)
	sendpackage(srvname,"login","register",args)
end

function login.createrole(srvname,args)
	sendpackage(srvname,"login","createrole",args)
end

function login.login(srvname,args)
	sendpackage(srvname,"login","login",args)
end

function login.entergame(srvname,args)
	sendpackage(srvname,"login","entergame",args)
end

return login
