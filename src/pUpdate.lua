local z = ...

local function isI(c)
	return (c == "level" or c == "led")
end

local function tx(s, f)
	if not s then return end
	uart.on("data", "\n", f, 0)
	uart.write(0, s.."\n")
end

local function storeP(p, f)
	if not p or p.t == "A" then f(nil) return end
	if not p.p then p.p = 0 end
	local r = "CE P"..p.p
	if isI(p.c) then
		r = r..(p.u and " I1" or " I0")
	else
		r = r.." O"..p.t
	end
	tx(r, function(x)
		x = nil
		uart.on("data")
		if not isI(p.c) then
			tx(p.t.."E P"..p.p.." V"..(p.v or "0"), f)
		else
			f(nil)
		end
	end)
end

return function(d)
	package.loaded[z] = nil
	z = nil
	collectgarbage()
	local i = #d + 1
	local function f(x)
		x = nil
		i = i - 1
		uart.on("data")
		collectgarbage()
		if i > 0 then
			storeP(d[i], f)
		else
			d = nil
			collectgarbage()
		end
	end
	f(nil)
end