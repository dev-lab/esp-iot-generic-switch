ls = ""
cfg = {}
tmr.alarm(0,2000,0,function()
	--uart.setup(0,115200,8,0,1,1)
	uart.setup(0, 115200, 8, 0, 1, 0)
	uart.write(0, "\n\n")
	require("connect")(function()
		tmr.alarm(0,100,0,function()
			collectgarbage()
			require("http")
			require("dnsLiar")
		end)
	end)
end)