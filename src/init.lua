ls = ""
cf = {}
local t = tmr.create()
t:register(2000,0,function(t)
	if not cjson then _G.cjson = sjson end
	uart.setup(0, 115200, 8, 0, 1, 0)
	uart.write(0, "\n\n")
	require("connect")(function()
		local s = tmr.create()
		s:register(100,0,function(s)
			require("http")
			require("dnsLiar")
		end)
		s:start()
	end)
end)
t:start()
