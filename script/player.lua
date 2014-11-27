require "script.base"

cplayer = class("cplayer",cdatabaseable)

function cplayer:init()
	cdatabaseable.init(self,{
		pid = 0,
		flag = "cplayer",
	})
	self.data = {}
	self.enemy = nil
end

function cplayer:save()
	local data = {}
	data.data = self.data
	if self.enemy then
		data.enemy = self.enemy:save()
	end
	return data
end

function cplayer:load(data)
	if not data or not next(data) then
		return
	end
	self.data = data.data
	if data.enemy then
		self.enemy:load(data.enemy)
	end
end

function cplayer:getobject(pid)
	if pid == self:query("pid") then
		return self
	end
	return self.enemy
end

function cplayer:ishero(id)
	if id == 100 or id == 300 then
		return true
	end
	return false
end

__player = nil

function getplayer()
	if not __player then
		__player = cplayer.new()
		__player.enemy = cplayer.new()
	end
	return __player
end

return cplayer
