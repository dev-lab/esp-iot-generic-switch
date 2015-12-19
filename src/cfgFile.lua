local z = ...

local function getCfg()
	local c = {}
	if file.open("esp.cfg", "r") then
		c = cjson.decode(file.read())
		cfg[1] = c.aPwd
		cfg[2] = c.uPwd
		file.close()
		collectgarbage()
	end
	return c
end

local function setCfg(c)
	if file.open("esp.cfg", "w+") then
		file.write(cjson.encode(c))
		file.flush()
		file.close()
		collectgarbage()
	end
end

return function(p)
	package.loaded[z] = nil
	z = nil
	local c = getCfg()
	if not p then return c, nil, 200 end
	local d = {}
	if p.file then d = cjson.decode(p.file) end
	local m = p.m
	p = nil
	collectgarbage()
	if d.old == "" then d.old = nil end
	if d.pwd == "" then d.pwd = nil end
	local r = ""
	if m == "ap" then
		if d.pwd and #d.pwd < 8 then
			return c, "Password too short", 403
		end
		c.sta = d.opt
		c.ssid = d.ssid
		c.pwd = d.pwd
		tmr.alarm(2,2000,0,function()
			node.restart()
		end)
		r = "Setting AP: "..(c.ssid or "").." ..."
	elseif m == "admin" then
		if d.old ~= c.aPwd then
			return c, "Old password wrong", 403
		end
		c.aPwd = d.pwd
		cfg[1] = c.aPwd
		r = "Password changed for admin"
	elseif m == "user" then
		c.uPwd = d.pwd
		cfg[2] = c.uPwd
		r = "Password changed for user"
	else
		return c, "Unknown cfg", 403
	end
	d = nil
	m = nil
	collectgarbage()
	setCfg(c)
	return c, r, 200
end