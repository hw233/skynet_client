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
end

function REQUEST.endround(srvname,request)
end

function REQUEST.random_handcard(srvname,request)
end

function REQUEST.matchplayer(srvname,request)
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

function CMD.setweaponatk(srvname,pid,args)
end

function CMD.useskill(srvname,pid,args)
end
function CMD.putinwar(srvname,pid,args)
end

function CMD.removefromwar(srvname,pid,args)
end

function CMD.playcard(srvname,pid,args)

end

function CMD.launchattack(srvname,pid,args)
end

function CMD.putinhand(srvname,pid,args)
end

function CMD.removefromhand(srvname,pid,args)
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

function CMD.destroycard(srvname,pid,args)
end

function CMD.puttocardlib(srvname,pid,args)
end

function CMD.setatkcnt(srvname,pid,args)
end

function CMD.setleftatkcnt(srvname,pid,args)
end

function CMD.lookcards(srvname,pid,args)
end

function CMD.lookcards_discard(srvname,pid,args)
end

function CMD.clearhandcard(srvname,pid,args)
end

function CMD.set_magic_hurt_adden(srvname,pid,args)
end

function CMD.set_card_magic_hurt_adden(srvname,pid,args)
end

function CMD.setlrhalo(srvname,pid,args)
end

function CMD.cancelchoice(srvname,pid,args)
end

function CMD.addeffect(srcname,pid,args)
end

function CMD.deleffect(srcname,pid,args)
end

local RESPONSE = {}
netwar.RESPONSE = RESPONSE

return netwar
