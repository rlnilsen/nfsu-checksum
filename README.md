# nfsu-checksum
Calculates checksum of NFS Underground save games for PC and PS2.

### Requirements
- Lua 5.3 or newer.

### Usage
1. Create new directory named `nfsu-checksum`.
2. Download `nfsuchksumpc.lua` and `nfsuchksumps2.lua` from this repository to the new directory.
3. Copy a NFSU save game file (file name ends with .ugd (PC) or .nfs (PS2)) to the new directory.
4. Rename save game file to test.ugd (PC) or test.nfs (PS2).
5. Edit the save game file with your desired changes, using for example a hex editor.
5. Open a command prompt and go to the new directory.
6. Execute `lua nfsuchksumpc.lua` (PC) or `lua nfsuchksumps2.lua` (PS2). You may need to replace `lua` with `lua53` or `lua53.exe` or something else.
7. The calculated checksum will be shown.
8. Using a hex editor, change the four last bytes in the save game file to the shown checksum. You probably need to put the four bytes in reverse order.
9. Rename and copy the NFSU save game file to its original location.
