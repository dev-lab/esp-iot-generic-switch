ls = ""
cf = {}
tmr.create():alarm(2000, 0, function()
	if not cjson then _G.cjson = sjson end
	uart.setup(0, 115200, 8, 0, 1, 0)
	uart.write(0, "\n\n")
	require("connect")(function()
		tmr.create():alarm(100, 0, function()
			require("http")
			require("dnsLiar")
			pcall(function() require("apps")() end)
		end)
	end)
end)
