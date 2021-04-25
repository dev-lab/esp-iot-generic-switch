local z = ...

local function isI(c)
	return (c == "level" or c == "led")
end

local function tx(s, f)
	uart.on("data", "\n", function(v)
		v = nil
		uart.on("data")
		f()
	end, 0)
	uart.write(0, s.."\n")
end

local function storeP(p, f)
	if not p or p.t == "A" then f() return end
	if not p.p then p.p = 0 end
	local r = "CE P"..p.p
	if isI(p.c) then
		r = r..(p.u and " I1" or " I0")
	else
		r = r.." O"..p.t
	end
	tx(r, function()
		if not isI(p.c) then
			tx(p.t.."E P"..p.p.." V"..(p.v or "0"), f)
		else
			f()
		end
	end)
end

return function(d)
	package.loaded[z] = nil
	z = nil
	local x = 1
	local i = #d + 1
	tmr.create():alarm(10, 1, function(t)
		if not x then return end
		x = nil
		i = i - 1
		collectgarbage()
		if i > 0 then
			storeP(d[i], function() x = 1 end)
		else
			t:unregister()
			d = nil
			collectgarbage()
		end
	end)
end
