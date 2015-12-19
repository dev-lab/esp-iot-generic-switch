local z = ...

return function(co, p, e)
	package.loaded[z] = nil
	z = nil
	local res = {htm = "text/html", js = "application/javascript", json="application/json"}
	local m = res[e]
	res = nil
	e = nil
	local o = 0
	if m and file.open(p) then
		file.close()
		co:on("sent", function(c)
			tmr.wdclr()
			if not p then
				c:on("sent",function() end)
				c:close()
				c = nil
				collectgarbage()
				return
			end
			file.open(p)
			file.seek("set", o)
			local d = file.read(1024)
			file.close()
			if d then
				if #d < 1024 then
					p = nil
				else
					o = o + #d
				end
				c:send(d)
				d = nil
			else
				p = nil
				c:on("sent",function() end)
				c:close()
				c = nil
			end
			collectgarbage()
		end)
		collectgarbage()
		require("rs")(co, 200, nil, m)
	else
		require("rs")(co, 404, "Page not found")
	end
end