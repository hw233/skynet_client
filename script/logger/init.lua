logger = logger or {}
function logger.write(filename,msg)
	assert(string.match(filename,"^[a-z_]+[a-z_0-9/]*$"),"invalid log filename:" .. tostring(filename))
	fd = logger.gethandle(filename)
	fd:write(msg)
	fd:flush()
end
function logger.debug(filename,...)
	if logger.mode > logger.LOG_DEBUG then
		return
	end
	logger.write(filename,string.format("[%s] [%s] %s\n",os.date("%Y-%m-%d %H:%M:%S"),"DEBUG",table.concat({...},"\t")))
end

function logger.info(filename,...)
	if logger.mode > logger.LOG_INFO then
		return
	end
	logger.write(filename,string.format("[%s] [%s] %s\n",os.date("%Y-%m-%d %H:%M:%S"),"INFO",table.concat({...},"\t")))
end

function logger.warning(filename,...)
	if logger.mode > logger.LOG_WARNING then
		return
	end
	logger.write(filename,string.format("[%s] [%s] %s\n",os.date("%Y-%m-%d %H:%M:%S"),"WARNING",table.concat({...},"\t")))
end

function logger.error(filename,...)
	if logger.mode > logger.LOG_ERROR then
		return
	end
	logger.write(filename,string.format("[%s] [%s] %s\n",os.date("%Y-%m-%d %H:%M:%S"),"ERROR",table.concat({...},"\t")))
end

function logger.critical(filename,...)
	if logger.mode > logger.LOG_CRITICAL then
		return
	end
	logger.write(filename,string.format("[%s] [%s] %s\n",os.date("%Y-%m-%d %H:%M:%S"),"CRITICAL",table.concat({...},"\t")))
end

function logger.log(mode,filename,...)
	local log = assert(logger[mode],"invalid mode:" .. tostring(mode))
	assert(select("#",...) > 0,string.format("%s %s:null log",mode,filename))
	log(filename,...)
end

-- console/print
local __DEBUG = true
function logger.print(...)
	if __DEBUG then
		require "script.base"
		print(string.format("[%s]",os.date("%Y-%m-%d %H:%M:%S")),...)
	end
end

function logger.pprintf(fmt,...)
	if __DEBUG then
		require "script.base"
		pprintf(string.format("[%s] %s",os.date("%Y-%m-%d %H:%M:%S"),fmt),...)
	end
end

function logger.gethandle(name)
	if not logger.handles[name] then
		local filename = logger.path .. name .. ".log"
		local parent_path = string.match(name,"([^/]*)/.*")
		if parent_path then
			os.execute("mkdir -p " .. logger.path .. parent_path)
		end
		logger.handles[name] = io.open(filename,"a+b")
		assert(logger.handles[name],"logfile open failed:" .. tostring(filename))
	end
	return logger.handles[name]
end

function logger.setmode(mode)
	assert(type(mode) == "number","invalid logger mode:%s" .. tostring(mode))
	logger.mode = mode
end

function logger.init()
	print("logger init")
	logger.LOG_DEBUG = 1
	logger.LOG_INFO = 2
	logger.LOG_WARNING = 3
	logger.LOG_ERROR = 4
	logger.LOG_CRITICAL = 5
	logger.mode = logger.LOG_DEBUG
	logger.handles = {}
	logger.path = "./log/"
	os.execute(string.format("mkdir -p %s",logger.path))
	os.execute(string.format("ls -R %s > .log.tmp",logger.path))
	fd = io.open(".log.tmp","r")
	local filename
	local section = ""
	for line in fd:lines() do
		if line:sub(#line) == ":" then
			if line == logger.path .. ":" then
				section = ""
			else
				section = string.match(line,string.format("%s([^:]*):",logger.path))
			end
		else
			if line:sub(#line-3) == ".log" then
				if section ~= "" then
					name = section .. "/" .. line:sub(1,#line-4)
				else
					name = line:sub(1,#line-4)
				end
				filename = logger.path .. name .. ".log"
				--print(filename)
				logger.handles[name] = io.open(filename,"a+b")
			end
		end
	end
	fd:close()
	os.execute("rm -rf .log.tmp")
end

function logger.shutdown()
	print("logger shutdown")
	for name,fd in pairs(logger.handles) do
		fd:close()
	end
	logger.handles = {}
end
return logger
