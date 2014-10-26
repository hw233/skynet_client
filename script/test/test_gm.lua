require "script.base"
require "script.test.test_login"

local function test()
	login("gs","robert1","123")	
	login("gs","robert2","123")
end

return test
