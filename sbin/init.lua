-- Basically the CC-UNIX init script :P --

local panic = ...

local INIT_VERSION = "0.0.1"

-- Messy
write("\n")
term.setTextColor(0x6699FF)
write("  OCInit ")
term.setTextColor(0x66EE33)
write(INIT_VERSION)
term.setTextColor(0xFFFFFF)
write(" starting up ")
term.setTextColor(0xFFFF00)
write(kernel.version().."\n\n")
term.setTextColor(0xFFFFFF)
-- /Messy

kernel.log("Starting init services")
local initd = fs.list("/etc/init.d")
for i=1, #initd, 1 do
  kernel.log("Loading /etc/init.d/" .. initd[i])
  local ok, err = loadfile("/etc/init.d/" .. initd[i])
  if not ok then
    panic("Error " .. err .. " in " .. initd[i])
  end
  ok()
end

kernel.log("Starting shell")
local ok, err = loadfile("/bin/sh.lua")
if not ok then
  panic(err)
end
ok()
