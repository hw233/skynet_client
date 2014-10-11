local test = {}

function test.dispatch(srvname,typ,...)
	local srv = socketmgr.getsrv(srvname)
	if typ == "REQUEST"	then
		local cmd,args,response = ...
		local func = assert(REQUEST[cmd])
		func(srvname,args,response)
	else
		assert(typ == "RESPONSE")
		local session,args = ...
		local onresponse = srv.sessions[session]
		if onresponse then
			onresponse(srvname,args)
		end
	end
end
return test
