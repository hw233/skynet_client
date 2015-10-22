local srvname = "gamesrv_100"
function moveto(pos)
	sendpackage(srvname,"scene","move",{
		dstpos=pos,
		time = os.time(),
	})	
end

function enterscene(sceneid,pos)
	sendpackage(srvname,"scene","enter",{
		sceneid = sceneid,
		pos = pos,
	})
end

function stop()
	sendpackage(srvname,"scene","stop",{})
end

function setpos(pos)
	sendpackage(srvname,"scene","setpos",{
		pos = pos,
	})
end

local ALL_POS = {
	{x=1,y=1,dir=1},
	{x=2,y=2,dir=1},
	{x=3,y=3,dir=1},
	{x=4,y=4,dir=1},
	{x=5,y=5,dir=1},
	{x=6,y=6,dir=1},
	{x=7,y=7,dir=1},
	{x=8,y=8,dir=1},
	{x=9,y=9,dir=1},
	{x=10,y=10,dir=1},
	{x=11,y=11,dir=1},
	{x=12,y=12,dir=1},
	{x=13,y=13,dir=1},
	{x=14,y=14,dir=1},
	{x=15,y=15,dir=1},
	{x=16,y=16,dir=1},
}

function randompos()
	local i = math.random(#ALL_POS)
	return ALL_POS[i]
end

local ALL_SCENEID = {1,2,3,4,5,6}
	
function randomsceneid()
	local i = math.random(#ALL_SCENEID)
	return ALL_SCENEID[i]
end

function ishit(num,limit)
	return math.random(1,limit) <= num
end

local allcmd = {
	moveto = 5,
	stop = 4,
	setpos = 90,
	enterscene = 1,
}

function callback()
	print("onlogin")
	local socket = require "clientsocket"
	while true do
		socket.usleep(1000000)
		local cmd = choosekey(allcmd)
		print("cmd:",cmd)
		if cmd == "moveto" then
			local pos = randompos()
			moveto(pos)
		elseif cmd == "stop" then
			stop()
		elseif cmd == "setpos" then
			local pos = randompos()
			setpos(pos)
		elseif cmd == "enterscene" then
			local sceneid = randomsceneid()
			local pos = randompos()
			enterscene(sceneid,pos)
		end
	end
	moveto(pos)
	enterscene(sceneid,pos)
end

function main(...)
	local pid = ...
	assert(tonumber(pid),"Invliad pid:"..tostring(pid))
	login = require "script.test.test_login"
	local account = "#" .. pid
	local passwd = "6c676c"
	login(srvname,account,passwd,callback)
end

local modname = ...
if modname ~= "script.test.test_robert" then
	main(...)
end
return main
