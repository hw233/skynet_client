local protomgr = require "proto.protomgr"
local socket = require "clientsocket"

local proto = {}
--session = session or 0
local function send_package(fd,pack)
	local size = #pack
	local package = string.char(bit32.extract(size,8,8)) ..
		string.char(bit32.extract(size,0,8)) ..
		pack
	socket.send(fd,package)
end

local function unpack_package(text)
	local size = #text
	if size < 2 then
		return nil,text
	end
	local s = text:byte(1) * 256 + text:byte(2)
	if size < s + 2 then
		return nil,text
	end
	return text:sub(3,2+s),text:sub(3+s)
end

local function recv_package(last)
	local result
	result,last = unpack_package(last)
	if result then
		return result,last
	end
	local r = socket.recv()
end

local session = 0
function send_request(protoname,cmd,args)
	session = session + 1	
	local protoobj = protomgr.getproto(protoname)	
	local str = protoobj.request(cmd,args,session)
	send_package(fd,str)
end

function proto.init()
	protomgr.init()
end
return proto
