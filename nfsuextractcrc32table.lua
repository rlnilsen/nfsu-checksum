local function extract(filename, offset, count)
	local file = assert(io.open(filename, 'rb'))
	local outfile = assert(io.open([[outfile.lua]], 'w'))
	
	assert(file:seek('set', offset))
	
	for i=1, count do
		local u32 = assert(file:read(4))
		u32 = ('<I4'):unpack(u32)
		assert(outfile:write(('0x%08x, '):format(u32)))
		if i % 4 == 0 then
			outfile:write('\n');
		end
	end
	
	outfile:close()
	file:close()
end

--extract crc32 table from nfsu pcsx2 savestate's eeMemory.bin
--offset and size args were found by reverse engineering 
--disassembly of function z_un_002bdef8 in nfsu_re.txt
extract([[eeMemory.bin]], 0x40E698, 256)
