local z = ...

local function save(v)
	if v == nil then return "Nothing" end
	return require("fSaveI")(v)
end

local function after(c, v)
	local rs = true
	if v.name == "ports.json" and v.flush == "1" then
		file.open("ports.json", "r")
		local d = cjson.decode(file.read()).gpio
		file.close()
		tmr.alarm(4,200,0,function() require("pUpdate")(d) end)
	end
	v = nil
	collectgarbage()
	require("rs")(c, 200)
end

return function(c,v,u)
	package.loaded[z] = nil
	z = nil
	collectgarbage()
	if u > 1 then
		require("rs")(c, 401)
	else
		local er = save(v)
		if er == nil then
			after(c, v)
		else
			require("rs")(c, 403, "Not saved: "..er)
		end
	end
end
