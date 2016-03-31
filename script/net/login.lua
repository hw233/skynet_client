
netlogin = netlogin or {}
-- s2c
local REQUEST = {}
netlogin.REQUEST = REQUEST

function REQUEST.kick(srvname,request)
	print("close",srvname)
	socketmgr.close(srvname)	
end

function REQUEST.queue(srvname,request)
end

function REQUEST.reentergame(srvname,request)
	local go_srvname = assert(request.go_srvname)	
	local token = assert(request.token)
	local player = getplayer(srvname)
	local roleid = player.roleid
	sendpackage(go_srvname,"login","entergame",{
		roleid = roleid,
		token = token,
	})
end

local RESPONSE = {}
netlogin.RESPONSE = RESPONSE

function RESPONSE.register(srvname,request,response)
	local result = assert(response.result)
	print("register",result)
	if result == STATUS_OK then
	elseif result == STATUS_ACCT_AREADY_EXIST then
	end
end

function RESPONSE.login(srvname,request,response)
	local result = assert(response.result)
	print("login",result)
	if result == STATUS_OK then
	elseif result == STATUS_ACCT_NOEXIST then
	elseif result == STATUS_PASSWD_NOMATCH then
	end
end

function RESPONSE.createrole(srvname,request,response)
	local result = assert(response.result)
	print("createrole",result)
	if result == STATUS_OK then
		local role = assert(response.newrole)
	elseif result == STATUS_ROLETYPE_INVALID then
	elseif result == STATUS_NAME_INVALID then
	end
end


function RESPONSE.entergame(srvname,request,response)
	local result = assert(response.result)
	print("entergame",result,srvname,request.roleid)
	if result == STATUS_OK then
		local player = getplayer(srvname)
		player.roleid = request.roleid
	end
end

return netlogin
