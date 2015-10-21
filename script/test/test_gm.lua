local login = require "script.test.test_login"


local function test(srvname)
	srvname = srvname or "gamesrv_100"
	login(srvname,"robert1","123")	
	login(srvname,"robert2","123")
end

return test
