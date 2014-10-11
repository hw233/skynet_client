local socket = require "clientsocket"
local protomgr = require "proto.protomgr"

-- conf
require "conf.srvlist"

local socketmgr = {}

function socketmgr.init()
	socketmgr.servers = {}
end



function socketmgr.getsrv(srvname)
	if not socketmgr.servers[srvname] then
		local srv = assert(srvlist[srvname],"unknow srvname:" .. tostring(srvname))
		local fd = assert(socket.connect(srv.ip,srv.port))
		local tmp = {
			fd = fd,
			session = 0,
			sessions = {} --FORMAT: {sessionid:response_callback}
			srvname = srvname,
			last = "",
		}
		socketmgr.servers[srvname] = tmp
		socketmgr.servers[fd] = tmp
	end
	return socketmgr.servers[srvname]
end

function socketmgr.delsrv(srvname)
	local fd = srvname
	if type(srvname) == "string" then
		fd = socketmgr.servers[srvname]
	else
		assert(type(srvname) == "integer")
		srvname = socketmgr.servers[fd]
	end
	socketmgr.servers[srvname] = nil
	socketmgr.servers[fd] = nil
end

function socketmgr.onclose(srvname)
	local srv = assert(socketmgr.servers[srvname])
	socketmgr.delsrv(srvname)
end

function socketmgr.unpack_package(text)
	local size = #text
	if size < 2 then
		return nil,text
	end
	local s = text:byte(1) * 256 + text:byte(2)
	if size < s + 2 then
		return nil,text
	end
	return text:sub(3,s+2),text:sub(s+3)
end

function socketmgr.recv_package(srvname)
	local srv = socketmgr.getsrv(srvname)
	local result
	result,srv.last = unpack_package(srv.last)
	if result then
		return result
	end
	local r = socket.recv(srv.fd)
	if not r then
		return nil
	end
	if r == "" then
		socketmgr.onclose(srvname)
		error "Server closed"
	end
	result,srv.last = socketmgr.unpack_package(srv.last .. r)
	return result
end

local function send_package(fd,pack)
	local size = #pack
	local package = string.char(bit32.extract(size,8,8)) ..
		string.char(bit32.extract(size,0,8)) ..
		pack
	socket.send(fd,package)
end

function socketmgr.send_request(srvname,protoname,cmd,args,onresponse)
	local srv = socketmgr.getsrv(srvname)
	local fd = assert(srv.fd)
	local protoobj = protomgr.getproto(protoname)
	session = session + 1
	srv.sessions[session] = onresponse
	local str = protoobj.request(cmd,args,session)
	send_package(fd,str)
end

function socketmgr.dispatch()
	for srvname,srv in pairs(socketmgr.servers)	do
		while true do
			local v = socketmgr.recv_package(srvname)
			if not v then
				break
			end
			protomgr.dispatch(srvname,v)
		end
	end
end

return socketmgr
