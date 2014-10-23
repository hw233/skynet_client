require "script.base"
local login = require "script.test.test_login"

function test()
	login("gs","robert1","123")	
	login("gs","robert2","123")
end

return test
