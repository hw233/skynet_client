function runrobert(num,startpid)
	startpid = startpid or 10000
	local robert = "./script/test/test_robert.lua"
	for i=1,num do
		local pid = startpid + i
		os.execute(string.format("lua script/init.lua -f %s %s &",robert,pid))
	end
end

runrobert(...)
