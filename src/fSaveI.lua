local z = ...

return function(v)
	package.loaded[z] = nil
	z = nil
	local n = v.name
	local p = tonumber(v.pos)
	if p == 0 then p = nil end
	local f = v.file
	local fl = tonumber(v.flush)
	if fl == 0 then fl = nil end
	if not n or not f then return "File body missing" end
	local n1 = "~"..n
	local n2 = "-"..n1
	if not p then
		file.remove(n2)
	end
	local rm, _, _ = file.fsinfo()
	if (rm - (p and 1 or 500)) < #f then
		return "Not enough space on disk"
	end
	file.open(n2, "a")
	if p ~= nil and p > 0 then
		local cur = file.seek("end")
		if cur ~= p then
			file.close()
			return "File seek error, pos: "..p..", cur: "..(cur or "nil")
		end
	end
	if not file.write(f) then
		file.seek("set", p)
		if not file.write(f) then
			file.close()
			return "File write error, pos: "..p
		end
	end
	file.flush()
	file.close()
	if fl == 1 then
		if file.open(n) then
			file.close()
			file.remove(n1)
			file.rename(n, n1)
		end
		if not file.rename(n2, n) then
			if not file.rename(n2, n) then
				file.rename(n1, n)
				return "File rename error"
			end
		end
		file.remove(n1)
	end
	n1 = nil
	n2 = nil
	n = nil
	f = nil
	collectgarbage()
	return nil
end