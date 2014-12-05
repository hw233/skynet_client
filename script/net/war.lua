require "script.base"
require "script.socketmgr"

local player = getplayer()

netwar = netwar or {}
-- c2s


-- s2c
local REQUEST = {} 
netwar.REQUEST = REQUEST
function REQUEST.startwar(srvname,request)
	player:delete("hero")
	player:delete("handcards")
	player:delete("footman")
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
		--func(srvname,pid,args)
		xpcall(func,onerror,srvname,pid,args)
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
	local obj = player:getobject(pid)
	local id = assert(args.id)
	local atk = assert(args.value)
	if obj:ishero(id) then
		obj:set("hero.atk",atk)
	else
		local id_card = obj:query("id_card")
		local warcard = id_card[args.id]
		warcard.atk = atk
	end
end

function CMD.setcrystalcost(srvname,pid,args)
end

function CMD.sethp(srvname,pid,args)
	local obj = player:getobject(pid)
	local id = assert(args.id)
	local hp = assert(args.value)
	if obj:ishero(id) then
		obj:set("hero.hp",hp)
	else
		local id_card = obj:query("id_card")
		local warcard = id_card[args.id]
		warcard.hp = hp
	end
end

function CMD.silence(srvname,pid,args)
end
function CMD.synccard(srvname,pid,args)
	local obj = player:getobject(pid)
	local warcard = assert(args.warcard)
	local id_card = obj:query("id_card",{})
	id_card[id] = warcard
	obj:set("id_card",id_card)
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
	local id_card = obj:query("id_card",{})
	local pos = assert(args.pos)
	local warcard = assert(args.warcard)
	pos = math.min(pos,#footman+1)
	table.insert(footman,pos,warcard)
	id_card[warcard.id] = warcard
	obj:set("footman",footman)
	obj:set("id_card",id_card)
end

function CMD.delfootman(srvname,pid,args)
	local obj = player:getobject(pid)
	local footman = obj:query("footman")
	for i,v in ipairs(footman) do
		if v.id == args.id then
			table.remove(footman,i)
			local id_card = obj:query("id_card")
			id_card[v.id] = nil
			break
		end
	end
end

function CMD.playcard(srvname,pid,args)

end

function CMD.launchattack(srvname,pid,args)
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
	local obj = player:getobject(pid)
	local id = assert(args.id)
	local state = assert(args.state) 
	local value = assert(args.value)
	if obj:ishero(id) then
		local herostate = obj:query("hero.state",{})
		herostate.state[state] = value
		obj:set("hero.state",herostate)
	else
		local id_card = obj:query("id_card")
		local warcard = id_card[args.id]
		warcard.state[state] = value
	end
end

function CMD.delstate(srvname,pid,args)
	local obj = player:getobject(pid)
	local id = assert(args.id)
	local state = assert(args.state) 
	if obj:ishero(id) then
		local herostate = obj:query("hero.state",{})
		herostate.state[state] = nil
		obj:set("hero.state",herostate)
	else
		local id_card = obj:query("id_card")
		local warcard = id_card[id]
		warcard.state[state] = nil
	end
end

function CMD.destroycard(srvname,pid,args)
end

function CMD.puttocardlib(srvname,pid,args)
end

function CMD.setatkcnt(srvname,pid,args)
end

function CMD.setleftatkcnt(srvname,pid,args)
	local obj = player:getobject(pid)
	local id = assert(args.id)
	local value = assert(args.value)
	if obj:ishero(id) then
		obj:set("hero.leftatkcnt",value)
	else
		local id_card = obj:query("id_card")
		local warcard = id_card[id]
		warcard:set("leftatkcnt",value)
	end
end


local RESPONSE = {}
netwar.RESPONSE = RESPONSE

return netwar
