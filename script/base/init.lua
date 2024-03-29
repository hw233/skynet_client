require "script.base.class"
require "script.base.functor"
require "script.base.databaseable"
require "script.base.netcache"
require "script.errcode"

unpack = unpack or table.unpack

STARTTIME1 = 1408896000  --2014-08-25 00:00:00 Mon Aug
STARTTIME2 = 1408809600  --2014-08-24 00:00:00 Sun Aug
HOUR_SECS = 3600
DAY_SECS = 24 * HOUR_SECS 
WEEK_SECS = 7 * DAY_SECS

--用户必须保证对象非递归嵌套表
function self_tostring(obj)
	if type(obj) ~= "table" then
		return tostring(obj)
	end
	local cache = {}
	table.insert(cache,"{")
	for k,v in pairs(obj) do
		if type(k) == "number" then
			--table.insert(cache,self_tostring(v)..",")
			table.insert(cache,string.format("[%d]=%s,",k,self_tostring(v)))
		else
			local str = string.format("%s=%s,",self_tostring(k),self_tostring(v))
			table.insert(cache,str)	
		end
	end
	table.insert(cache,"}")
	return table.concat(cache)
end

function format(fmt,...)
	--local args = {...}	--无法处理nil值参数
	local args = table.pack(...)
	local len = math.max(#args,args.n or 0)
	for i = 1, len do
		if type(args[i]) == "table" then
			args[i] = self_tostring(args[i])
		elseif type(args[i]) ~= "number" then
			args[i] = tostring(args[i])
		end
	end
	return string.format(fmt,unpack(args))
end

function printf(fmt,...)
	print(format(fmt,...))
end

function pretty_tostring(obj,indent)
	if type(obj) ~= "table" then
		return tostring(obj)
	end
	local cache = {}
	table.insert(cache,"{")
	indent = indent + 4
	for k,v in pairs(obj) do
		if type(k) == "number" then
			table.insert(cache,string.rep(" ",indent) .. string.format("[%d]=%s,",k,pretty_tostring(v,indent)))
		else
			local str = string.rep(" ",indent) .. string.format("%s=%s,",pretty_tostring(k,indent),pretty_tostring(v,indent))
			table.insert(cache,str)	
		end
	end
	indent = indent - 4
	table.insert(cache,string.rep(" ",indent) .. "}")
	return table.concat(cache,"\n")
end

function pretty_format(fmt,...)
	--local args = {...}	--无法处理nil值参数
	local args = table.pack(...)
	local len = math.max(#args,args.n or 0)
	for i = 1, len do
		if type(args[i]) == "table" then
			args[i] = pretty_tostring(args[i],0)
		elseif type(args[i]) ~= "number" then
			args[i] = tostring(args[i])
		end
	end
	return string.format(fmt,unpack(args))
end

function pprintf(fmt,...)
	print(pretty_format(fmt,...))
end


function keys(t)
	local ret = {}
	for k,v in pairs(t) do
		table.insert(ret,k)
	end
	return ret
end

function values(t)
	local ret = {}
	for k,v in pairs(t) do
		table.insert(ret,v)
	end
	return ret
end

function remove_from(t,val,maxcnt)
	local delkey = {}
	for k,v in pairs(t) do
		if v == val then
			if not maxcnt or #delkey < maxcnt then
				delkey[#delkey] = k
			else
				break
			end
		end
	end
	for _,k in pairs(delkey) do
		t[k] = nil
	end
	return #delkey
end

function list(t)
	local ret = {}
	for k,v in pairs(t) do
		ret[#ret+1] = v
	end
	return ret
end

function range(b,e,step)
	step = step or 1
	if not e then
		e = b
		b = 1
	end
	local list = {}
	for i = b,e,step do
		table.insert(list,i)
	end
	return list
end


local function less_than(lhs,rhs)
	return lhs < rhs
end

function lower_bound(t,val,cmp)
	cmp = cmp or less_than
	local len = #t
	local first,last = 1,len + 1
	while first < last do
		local pos = math.floor((last-first) / 2) + first
		if not cmp(t[pos],val) then
			last = pos
		else
			first = pos + 1
		end
	end
	if last > len then
		return nil
	else
		return last
	end
end

function uppper_bound(t,val,cmp)
	cmp = cmp or less_than
	local len = #t
	local first,last = 1,len + 1
	while first < last do
		local pos = math.floor((last-first)/2) + first
		if cmp(val,t[pos]) then
			last = pos
		else
			first = pos + 1
		end
	end
	if last > len then
		return nil
	else
		return last
	end
end



--function xrange(b,e,step)
--	step = step or 1
--	if not e then
--		e = b
--		b = 1
--	end
--	return iter(range(b,e,step))
--end
--
---- same as pairs
--function iter(t)
--	local t = t
--	local k = nil
--	function _iter()
--		k,v = next(t,k)
--		return k,v
--	end
--	return _iter
--end



function slice(list,b,e,step)
	step = step or 1
	if not e then
		e = b
		b = 1
	end
	e = math.min(#list,e)
	local new_list = {}
	local len = #list
	local idx
	for i = b,e,step do
		idx = i >= 0 and i or len + i + 1
		table.insert(new_list,list[idx])
	end
	return new_list
end

function filter(t,func)
	assert(func ~= nil)
	local ret = {}
	for k,v in pairs(t) do
		if func(k,v) then
			ret[k] = v
		end
	end
	return ret
end

function map(func,...)
	local args = {...}
	assert(#args >= 1)
	local maxlen,num = 0,#args
	for i = 1, num do
		if #args[i] > maxlen then
			maxlen = #args[i]
		end
	end
	local ret = {}
	for i = 1, maxlen do
		local list = {}
		for j = 1, num do
			table.insert(list,args[j][i])
		end
		table.insert(ret,func(unpack(list)))
	end
	return ret
end

--copy
-------------------------------------------------------------
-- lua元素复制接口,提供浅复制(copy)和深复制两个接口(deepcopy)
-- 深复制解决以下3个问题:
-- 1. table存在循环引用
-- 2. metatable(metatable都不参与复制)
-- 3. keys也是table
--------------------------------------------------------------
function copy(o)
	local typ = type(o)
	if typ ~= "table" then return o end
	local newtable = {}
	for k,v in pairs(o) do
		newtable[k] = v
	end
	return setmetatable(newtable,getmetatable(o))
end


function deepcopy(o,seen)
	local typ = type(o)
	if typ ~= "table" then return o end
	seen = seen or {}
	if seen[o] then return seen[o] end
	local newtable = {}
	seen[o] = newtable
	for k,v in pairs(o) do
		newtable[deepcopy(k,seen)] = deepcopy(v,seen)
	end
	return setmetatable(newtable,getmetatable(o))
end

--ratio
function ishit(num,limit)
	assert(limit >= num)
	limit = limit or 100
	return math.random(1,limit) <= num
end

function shuffle(list,inplace)
	if not inplace then
		list = deepcopy(list)
	end
	local idx,tmp
	local len = #list
	for i = 1,len-1 do
		idx = math.random(i,len)
		tmp = list[idx]
		list[idx] = list[i]
		list[i] = tmp
	end
	return list
end


function randlist(list)
	assert(#list > 0,"list length need > 0")
	local pos = math.random(1,#list)
	return list[pos]
end



function choosevalue(dct)
	local sum = 0
	for ratio,_ in pairs(dct) do
		sum = sum + ratio
	end
	local hit = math.random(1,sum)
	local limit = 0
	for ratio,val in pairs(dct) do
		limit = limit + ratio
		if hit <= limit then
			return val
		end
	end
	return nil
end

function choosekey(dct)
	local sum = 0
	for _,ratio in pairs(dct) do
		sum = sum + ratio
	end
	local hit = math.random(1,sum)
	local limit = 0
	for key,ratio in pairs(dct) do
		limit = limit + ratio
		if hit <= limit then
			return key
		end
	end
	return nil
end

-- time
function gethourno(flag)
	local start = flag and STARTTIME2 or STARTTIME1
	local tm = os.time() - start
	return math.floor(tm/HOUR_SECS) + (tm % HOUR_SECS == 0 and 0 or 1)
end

function getdayno(flag)
	local start = flag and STARTTIME2 or STARTTIME1
	local tm = os.time() - start
	return math.floor(tm/DAY_SECS) + (tm % DAY_SECS == 0 and 0 or 1)
end

function getweekno(flag)
	local start = flag and STARTTIME2 or STARTTIME1
	local tm = os.time() - start
	return math.floor(tm/WEEK_SECS) + (tm % WEEK_SECS == 0 and 0 or 1)
end

function getsecond()
	return os.time()
end

function getyear(now)
	now = now or os.time()
	local s = os.date("%Y",now)
	return tonumber(s)
end

function getyearmonth(now)
	now = now or os.time()
	local s = os.date("%m",now)
	return tonumber(s)
end

function getmonthday(now)
	now = now or os.time()
	local s = os.date("%d",now)
	return tonumber(s)
end

--星期天为0
function getweekday(now)
	now = now or os.time()
	local s = os.date("%w",now)
	return tonumber(s)
end

function getdayhour(now)
	now = now or os.time()
	local s = os.date("%H",now)
	return tonumber(s)
end

function gethourminute(now)
	now = now or os.time()
	local s = os.date("%M",now)
	return tonumber(s)
end

function getminutesecond(now)
	now = now or os.time()
	local s = os.date("%S",now)
	return tonumber(s)
end

--今天过去的秒数
function getdaysecond()
	now = os.time()
	return getdayhour(now) * HOUR_SECS + gethourminute(now) * 60 + getminutesecond(now)
end

--今天0点时间(秒为单位)
function getdayzerotime()
	return getsecond() - getdaysecond()
end

--string
function isdigit(str)
	local ret = pcall(tonumber,str)
	return ret
end

function hexstr(str)
	assert(type(str) == "string")
	local len = #str
	return string.format("0x" .. string.rep("%x",len),string.byte(str,1,len))
end

local WHITECHARS_PAT = "%S+"
function split(str,pat,maxsplit)
	pat = pat or WHITECHARS_PAT
	maxsplit = maxsplit or -1
	local ret = {}
	local i = 0
	for s in string.gmatch(str,pat) do
		if not (maxsplit == -1 or i <= maxsplit) then
			break
		end
		table.insert(ret,s)
	end
	return ret
end

--filesystem
function currentdir()
	local ok,ret = pcall(require,"lfs")
	if ok then
		return lfs.currentdir()
	end
	local fd = popen("pwd")
	local path = fd:read("*all")
	print (path)
	return path
end


-- package
function sendpackage(srvname,protoname,cmd,args,onresponse)
	require "script.socketmgr"
	socketmgr.send_request(srvname,protoname,cmd,args,onresponse)
end
