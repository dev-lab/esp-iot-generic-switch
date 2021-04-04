local z = ...

return function(co, d)
	package.loaded[z] = nil
	z = nil
	local e = false
	co:on("sent", function(c)
		tmr.wdclr()
		if e then
			c:close()
			c = nil
			collectgarbage()
			return
		end
		c:send(cjson.encode(d))
		d = nil
		e = true
		collectgarbage()
	end)
	require("rs")(co, 200, "", "application/json")
	collectgarbage()
end
