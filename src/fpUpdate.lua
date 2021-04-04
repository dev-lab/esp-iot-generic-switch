local z = ...

return function()
	package.loaded[z] = nil
	z = nil
	local f = file.open("ports.json")
	local d = cjson.decode(f:read()).gpio
	f:close(); f = nil
	local t = tmr.create()
	t:register(200,0,function(t) require("pUpdate")(d) end)
	t:start()
end
