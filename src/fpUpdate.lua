local z = ...

return function()
	package.loaded[z] = nil
	z = nil
	local f = file.open("ports.json")
	local d = cjson.decode(f:read()).gpio
	f:close(); f = nil
	tmr.create():alarm(200, 0, function() require("pUpdate")(d) end)
end
