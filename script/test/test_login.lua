local function test(srvname,account,passwd,callback)
	function onlogin(srvname,request,response)
		local result = assert(response.result)	
		pprintf("login:%s,roles:%s",result,response.roles)
		if result == STATUS_ACCT_NOEXIST then
			sendpackage(srvname,"login","register",{
				account = account,
				passwd = passwd,
			},onregister)
		elseif result == STATUS_OK then
			local roles = response.roles
			if not roles or #roles == 0 then
				sendpackage(srvname,"login","createrole",{
					account = account,
					roletype = 1001,
					name = account,
				},oncreaterole)
			else
				local role = assert(roles[1],"no role")
				sendpackage(srvname,"login","entergame",{
					roleid = role.roleid,
				},onentergame)
			end
			
		end
	end

	function onregister(srvname,request,response)
		local result = assert(response.result)
		print("register:",result)
		if result == STATUS_OK then
			sendpackage(srvname,"login","createrole",{
				account = account,
				roletype = 1001,
				name = account,
			},oncreaterole)
		end
	end

	function oncreaterole(srvname,request,response)
		local result = assert(response.result)
		print("createrole:",result) 
		if result == STATUS_OK then
			local role = assert(response.newrole)
			sendpackage(srvname,"login","entergame",{
				roleid = role.roleid,
			},onentergame)
		end
	end

	function onentergame(srvname,request,response)
		local result = assert(response.result)
		print("entergame ",result==0 and "ok" or "fail")
		pprintf("request:%s",request)
		if callback then
			callback()
		end
		net.login.RESPONSE.entergame(srvname,request,response)
	end

	sendpackage(srvname,"login","login",{
		account = account,
		passwd = passwd,
	},onlogin)
end

return test
