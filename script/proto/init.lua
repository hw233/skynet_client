local socket = require "clientsocket"
local sproto = require "sproto"

proto = proto or {}

local function onrequest(srvname,cmd,request,response)
	pprintf("[recv] REQUEST:%s\n",{
		srvname = srvname,
		cmd = cmd,
		request = request,
	})

	local protoname,subprotoname = string.match(cmd,"([^_]-)%_(.+)") 
	if not net[protoname] then
		print(format("unknow proto,srvname=%s cmd=%s request=%s",srvname,cmd,request))
		return
	end
	local REQUEST = net[protoname].REQUEST
	local func = REQUEST[subprotoname]
	if not func then
		print(format("unknow cmd,srvname=%s cmd=%s request=%s",srvname,cmd,request))
		return
	end
	local r = func(srvname,request)
	pprintf("[send] RESPONSE:%s\n",{
		srvname=  srvname,
		cmd = cmd,
		response = r,
	})
	if response then
		return response(r)
	end
end

local function onresponse(srvname,session,response)
	pprintf("[recv] RESPONSE:%s\n",{
		svrname = srvname,
		session = session,
		response = response,
	})
	local srv = socketmgr.getsrv(srvname)
	local ses = assert(srv.sessions[session],"error session id:%s" .. tostring(session))
	srv.sessions[session] = nil
	local callback = ses.onresponse
	if not callback then
		if net[ses.protoname] and net[ses.protoname].RESPONSE then
			callback = net[ses.protoname].RESPONSE[ses.cmd]
		end
	end
	if callback then
		callback(srvname,ses.request,response)
	end
end

local function dispatch(srvname,typ,...)
	if typ == "REQUEST" then
		local ok,result = pcall(onrequest,srvname,...)	
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
	--print(srvname,v)
	dispatch(srvname,proto.host:dispatch(v))
end


function proto.init()
	local text_proto = require "script.proto.proto"
	text_proto.dump()
	proto.host = sproto.parse(text_proto.s2c):host "package"
	proto.request = proto.host:attach(sproto.parse(text_proto.c2s))
end
return proto
