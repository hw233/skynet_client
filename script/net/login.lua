require "script.base"
require "script.socketmgr"
require "script.player"

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


local RESPONSE = {}
netlogin.RESPONSE = RESPONSE

function RESPONSE.register(srvname,request,response)
	local result = assert(response.result)
	print("register",result)
	local player = getplayer()
	if result == STATUS_OK then
		player:set("account",request.account)	
		player:set("passwd",request.passwd)
	elseif result == STATUS_ACCT_AREADY_EXIST then
	end
end

function RESPONSE.login(srvname,request,response)
	local result = assert(response.result)
	print("login",result)
	local player = getplayer()
	if result == STATUS_OK then
		player:set("account",request.account)	
		player:set("passwd",request.passwd)
	elseif result == STATUS_ACCT_NOEXIST then
	elseif result == STATUS_PASSWD_NOMATCH then
	end
end

function RESPONSE.createrole(srvname,request,response)
	local result = assert(response.result)
	print("createrole",result)
	local player = getplayer()
	if result == STATUS_OK then
		local role = assert(response.newrole)
		player:set("pid",role.roleid)
	elseif result == STATUS_ROLETYPE_INVALID then
	elseif result == STATUS_NAME_INVALID then
	end
end


function RESPONSE.entergame(srvname,request,response)
	local result = assert(response.result)
	print("entergame",result)
	local player = getplayer()
	if result == STATUS_OK then
		player:set("pid",request.roleid)
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
