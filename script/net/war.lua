require "script.base"
require "script.socketmgr"

local player = getplayer()

netwar = netwar or {}
-- c2s


-- s2c
local REQUEST = {} 
netwar.REQUEST = REQUEST
function REQUEST.startwar(srvname,request)

end


function REQUEST.warresult(srvname,request)
end

function REQUEST.beginround(srvname,request)
	player:set("state","beginround")
end

function REQUEST.endround(srvname,request)
	player:set("state","endround")
end

function REQUEST.random_handcard(srvname,request)
end

function REQUEST.matchplayer(srvname,request)
	local isattacker = request.isattacker
	if isattacker then
		player:set("id",300)
	else
		player:set("id",100)
	end
	player.enemy:set("pid",request.pid)
	player.enemy:set("race",request.race)
	player.enemy:set("name",request.name)
	player.enemy:set("lv",request.lv)
	player.enemy:set("photo",request.photo)
	player.enemy:set("show_achivelist",request.show_achivelist)
end

local CMD = {}
function REQUEST.sync(srvname,request)
	for _,cmd in ipairs(request.cmds) do
		local pid,cmd,args = cmd.pid,cmd.cmd,cmd.args
		local func = assert(CMD[cmd],"Invalid war cmd:" .. tostring(cmd))
		func(srvname,pid,args)
	end
end

function CMD.addbuff(srvname,pid,args)
end

function CMD.delbuff(srvname,pid,args)
end
function CMD.addhalo(srvname,pid,args)
end

function CMD.delhalo(srvname,pid,args)
end

function CMD.setmaxhp(srvname,pid,args)
end

function CMD.setatk(srvname,pid,args)
end
function CMD.setcrystalcost(srvname,pid,args)
end
function CMD.sethp(srvname,pid,args)
end

function CMD.silence(srvname,pid,args)
end
function CMD.synccard(srvname,pid,args)
end
function CMD.delweapon(srvname,pid,args)
end
function CMD.equipweapon(srvname,pid,args)
end
function CMD.setweaponusecnt(srvname,pid,args)
end
function CMD.useskill(srvname,pid,args)
end
function CMD.addfootman(srvname,pid,args)
	local obj = player:getobject(pid)
	local footman = obj:query("footman",{})
	local pos = args.pos
	table.insert(footman,pos,args.warcard)
	obj:set("footman",footman)
end

function CMD.delfootman(srvname,pid,args)
	local obj = player:getobject(pid)
	local footman = obj:query("footman")
	for i,v in ipairs(footman) do
		if v.id == args.id then
			table.remove(footman,i)
			break
		end
	end
end

function CMD.playcard(srvname,pid,args)
end
function CMD.footman_attack_footman(srvname,pid,args)
end
function CMD.hero_attack_footman(srvname,pid,args)
end
function CMD.hero_attack_hero(srvname,pid,args)
end
function CMD.putinhand(srvname,pid,args)
	print("putinhand",srvname,pid,args)
	local obj = player:getobject(pid)
	local handcards = obj:query("handcards",{})
	table.insert(handcards,args)
	obj:set("handcards",handcards)
end

function CMD.removefromhand(srvname,pid,args)
	print("removefromhand",srvname,pid,args)
	local obj = player:getobject(pid)
	local handcards = obj:query("handcards")
	for i,v in ipairs(handcards) do
		if v.id == args.id then
			table.remove(handcards,i)
			break
		end
	end
end

function CMD.addsecret(srvname,pid,args)
end

function CMD.delsecret(srvname,pid,args)
end

function CMD.setcrystal(srvname,pid,args)
end

function CMD.set_empty_crystal(srvname,pid,args)
end

function CMD.setstate(srvname,pid,args)
end
function CMD.delstate(srvname,pid,args)
end



local RESPONSE = {}
netwar.RESPONSE = RESPONSE

return netwar
