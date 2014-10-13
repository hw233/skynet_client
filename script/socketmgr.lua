require "base"
local socket = require "clientsocket"
local bit32 = require "bit32"

-- conf
require "conf.srvlist"

local socketmgr = {}

function socketmgr.init()
	socketmgr.servers = {}
	socketmgr.getsrv("gs")
end



function socketmgr.getsrv(srvname)
	if not socketmgr.servers[srvname] then
		local srv = assert(srvlist[srvname],"unknow srvname:" .. tostring(srvname))
		local fd = assert(socket.connect(srv.ip,srv.port))
		local tmp = {
			fd = fd,
			session = 0,
			sessions = {},
			srvname = srvname,
			last = "",
		}
		socketmgr.servers[srvname] = tmp
	end
	return socketmgr.servers[srvname]
end

function socketmgr.delsrv(srvname)
	socketmgr.servers[srvname] = nil
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
	result,srv.last = socketmgr.unpack_package(srv.last)
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

function socketmgr.send_package(srvname,pack)
	local srv = socketmgr.getsrv(srvname)
	local fd = assert(srv.fd)
	local size = #pack
	local package = string.char(bit32.extract(size,8,8)) ..
		string.char(bit32.extract(size,0,8)) ..
		pack
	socket.send(fd,package)
end


function socketmgr.send_request(srvname,protoname,cmd,args,onresponse)
	local proto = require "proto"
	local srv = socketmgr.getsrv(srvname)
	srv.session = srv.session + 1
	srv.sessions[srv.session] = {
		protoname = protoname,
		cmd = cmd,
		args = args,
		onresponse = onresponse,
	}
	local str = proto.request(protoname .. "_" .. cmd,args,srv.session)
	socketmgr.send_package(srvname,str)
end

function socketmgr.dispatch()
	local proto = require "proto"
	for srvname,srv in pairs(socketmgr.servers)	do
		print("srvname",srvname)
		while true do
			local v = socketmgr.recv_package(srvname)
			if not v then
				break
			end
			proto.dispatch(srvname,v)
		end
		cmds = {
			"test=require('net.test');test.handshake('gs')",
			"test=require('net.test');test.set({what='hello',value='world'})",
			"test=require('net.test');test.get({what='hello',})",
		}
		cmd = 
		if cmd then
			if cmd == "exit" then
				return "exit"
			end
			local func = load(cmd)	
			local ok,result = pcall(func)
			print(cmd,ok,result)
			socket.usleep(5000000)
		else
			socket.usleep(100)
		end
	end
end

return socketmgr
