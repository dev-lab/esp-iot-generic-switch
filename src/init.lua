ls = ""
cfg = {}
local t = tmr.create()
t:register(2000,0,function()
	if not cjson then _G.cjson = sjson end
	uart.setup(0, 115200, 8, 0, 1, 0)
	uart.write(0, "\n\n")
	require("connect")(function()
		local t2 = tmr.create()
		t2:register(100,0,function(t2)
			collectgarbage()
			require("http")
			require("dnsLiar")
		end)
		t2:start()
	end)
end)
t:start()
