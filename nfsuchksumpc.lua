--[[
NFSU PC save game checksum algorithm by CoDe RiPPeR:

File Offset        Description
-----------------  -------------------------------------------
0...0x2F           Header (saving date/time, type, name, etc.)
0x2F...0xF68F      Binary saved data, length 0xF660
0xF68F...0xF693    4-byte checksum of the above block

int chksum(const unsigned char *savedata)
{
    int i, bt = 0, csum = 0, k = 1;
    if ( savedata != NULL )
    {
        savedata += 0x2F;
        for (i=0; i < 0xF660; i++)
        {
            bt = savedata[i];
            k = (bt + k) % 0xFFF1;
            csum = (csum + k) % 0xFFF1;
        }
        csum = (csum << 16) + k;
    }
    return csum;
}
]]

local function checksum(file, nbytes)
	assert(file)
	local csum = 0
	local k = 1
	for i=1, nbytes do
		local bt = assert(file:read(1)):byte()
		k = (bt + k) % 0xfff1
		csum = (csum + k) % 0xfff1
	end
	csum = (csum << 16) + k
	return csum
end

local HEADER_SIZE = 0x2f
local DATA_SIZE = 0xf660
local CHECKSUM_SIZE = 0x4

--calculates and prints checksum of nfsu save file
--also prints checksum stored as last 4 bytes in file
--does not modify file
local function test(filename)
	local file = assert(io.open(filename, 'rb'))
	
	--skip header
	assert(file:read(HEADER_SIZE))
	
	local newcsum = checksum(file, DATA_SIZE)
	print(("calculated checksum: 0x%08x"):format(newcsum))
	
	local oldcsum = assert(file:read(CHECKSUM_SIZE))
	oldcsum = ('<I4'):unpack(oldcsum)
	print(("  existing checksum: 0x%08x"):format(oldcsum))
	
	file:close()
end

test [[test.ugd]]
