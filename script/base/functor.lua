--------------------------------------------------
--函数包装器(最后一个形参不能为nil,为nil会丢失参数),中间的nil值会自动转换成false
--用法: f = functor(print,1,"hello")
--      f(2,"world",nil,3) ==> 1,hello,2,world,nil,3
--------------------------------------------------
local callmeta = {}
callmeta.__call = function (func,...)
	args = {...}
	if type(func) == "function" then
		return func(...)
	elseif type(func) ~= "table" then
		print(debug.traceback("functor.call",1))
	else
		local allargs = func.__args
		local len = #allargs
		for i = 1, #args do
			allargs[len+i] = args[i] or false
		end
		return func.__fn(table.unpack(allargs))
	end
end

function functor(func,...)
	args = {...}
	-- 用false代替nil值，防止丢失位置参数
	for i = 1,#args do
		args[i] = args[i] or false
	end
	local wrap = {}
	wrap.__fn = func
	wrap.__args = args
	wrap.__name = "functor"  -- flag
	setmetatable(wrap,callmeta)
	return wrap
end

