local z = ...

return function(co,p)
	package.loaded[z] = nil
	z = nil
	uart.on("data", "\n", function(re)
		uart.on("data")
		collectgarbage()
		require("rs")(co, 200, node.heap().."\n"..re)
	end, 0)
	uart.write(0, (p.cmd or "NG").."\n")
end
