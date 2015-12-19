local z = ...

local function tx(s, f)
	if not s then return end
	uart.on("data", "\n", f, 0)
	uart.write(0, s.."\n")
end

local function loadP(p, f)
	if p.t then
		tx(p.t.."G P"..(p.p or "0"), function(v)
			uart.on("data")
			if v and #v > 4 then
				v = v:sub(5)
				p.v = tonumber(v)
			else
				p.v = 0
			end
			v = nil
			collectgarbage()
			f()
		end)
	else
		f()
	end
end

return function(co,p)
	package.loaded[z] = nil
	z = nil
	p = nil
	file.open("ports.json", "r")
	local d = cjson.decode(file.read())
	file.close()
	local gp = d.gpio
	tmr.wdclr()
	collectgarbage()
	local i = #gp + 1
	local function fo()
		tmr.wdclr()
		collectgarbage()
		i = i - 1
		if i > 0 then
			loadP(gp[i], fo)
		else
			loadP = nil
			tx = nil
			collectgarbage()
			require("sendJson")(co,d)
		end
	end
	fo()
end