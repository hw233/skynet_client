require "base"
local socket = require "clientsocket"
local sproto = require "sproto"
local net = require "net"

local proto = {}

function proto.register(protoname)
	local protomod = require("proto." .. protoname)
	proto.s2c = proto.s2c .. protomod.s2c
	proto.c2s = proto.c2s .. protomod.c2s
end

local function request(cmd,args,response)
	pprintf("REQUEST:%s",{
		cmd = cmd,
		args = args,
		response = response,
	})
	local protoname,cmd = string.match(cmd,"([^_]-)%_(.+)") 
	local REQUEST = net[protoname].REQUEST
	local func = assert(REQUEST[cmd],"unknow cmd:" .. protoname,"." .. cmd)
	local r = func(srvname,args)
	if response then
		return response(r)
	end
end

local function onresponse(srvname,session,args)
	pprintf("RESPONSE:%s",{
		svrname = srvname,
		session = session,
		args = args,
	})
	local srv = socketmgr.getsrv(srvname)
	local ses = assert(srv.sessions[session],"error session id:%s" .. tostring(session))
	local callback = ses.onresponse
	if not callback then
		callback = net[ses.protoname].RESPONSE[ses.cmd]
	end
	if callback then
		callback(srvname,session,args)
	end
	srv.sessions[session] = nil
end

local function dispatch(srvname,typ,...)
	if typ == "REQUEST" then
		local ok,result = pcall(request,...)	
		if ok then
			if result then
				socketmgr.send_package(srvname,result)
			end
		else
			print(result)
		end
	else
		assert(typ == "RESPONSE")
		onresponse(srvname,...)
	end
end

function proto.dispatch(srvname,v)
	dispatch(srvname,proto.host:dispatch(v))
end

function proto.init()
	proto.s2c = [[
.package {
	type 0 : integer
	session 1 : integer
}
]]
	proto.c2s = [[
.package {
	type 0 : integer
	session 1 : integer
}
]]
	for protoname,netmod in pairs(net) do
		proto.register(protoname)
	end
	pprintf("s2c:%s\nc2s:%s\nnet:%s",proto.s2c,proto.c2s,net)
	proto.host = sproto.parse(proto.s2c):host "package"
	proto.request = proto.host:attach(sproto.parse(proto.c2s))
end
return proto
