local z = ...

return function(co,p,u)
	package.loaded[z] = nil
	z = nil
	if u > 1 then
		require("rs")(co, 401)
	elseif not p then
		require("rs")(co, 403, "No config passed")
	else
		if p.m == "sta" then
			if p.file then
				local d = cjson.decode(p.file)
				if not d.pwd then
					d.pwd = ""
				elseif #d.pwd < 8 then
					require("rs")(co, 403, "Password shall be either 8 - 64 chars long, or not specified")
				end
				ls = "Connecting to: "..(d.ssid or "").." ..."
				local t = tmr.create()
				t:register(2000,0,function(t)
					d.save=true
					wifi.sta.config(d)
					t:register(2000,0,function(t)
						node.restart()
					end)
					t:start()
				end)
				t:start()
			end
			p = nil
			require("rs")(co, 200, ls)
		else
			local _, fm, fc = require("cfgFile")(p)
			p = nil
			require("rs")(co, fc, fm)
		end
	end
	collectgarbage()
end
