require "script.base"

local login = {}
-- s2c
local REQUEST = {}
login.REQUEST = REQUEST

function REQUEST.kick(srvname,request)

end

local RESPONSE = {}
login.RESPONSE = RESPONSE

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
		local roles = assert(response.roles)
		if #roles == 0 then
			-- login.createrole(xxx)
		end
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


function login.register(srvname,request)
	sendpackage(srvname,"login","register",request)
end

function login.createrole(srvname,request)
	sendpackage(srvname,"login","createrole",request)
end

function login.login(srvname,request)
	sendpackage(srvname,"login","login",request)
end

function login.entergame(srvname,request)
	sendpackage(srvname,"login","entergame",reqeust)
end

return login
