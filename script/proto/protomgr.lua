local protomgr = {}

function protomgr.register(protoname,netname)	
	local proto = require protoname
	local net = require netname
	local dispatch = assert(net.dispatch,"netmodule no dispatch:" .. tostring(netname))
	local host = sproto.new(proto.s2c):host "package"
	local request = host:attach(sproto.new(proto.c2s))
	local tmp = {
		proto = proto,
		host = host,
		request = request,
		--dispatch = host.dispatch,
		dispatch = dispatch,
	}
	protomgr.protos[protoname] = tmp
end

function protomgr.getproto(protoname)
	return protomgr.protos[protoname]
end

function protomgr.dispatch(srvname,v)
	for protoname,protoobj in pairs(protomgr.protos) do
		protoobj.dispatch(srvname,protoobj.host:dispatch(v))
	end
end

function protomgr.init()
	protomgr.protos = {}
	for protoname,netname in pairs(protos) do
		protomgr.register(protoname,netname)
	end
end

return protomgr
