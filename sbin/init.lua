-- Basically the CC-UNIX init script :P --

local panic = ...

if sh then
  error("Init is already running!")
  return false
end

-- Messy
write("\n")
term.setTextColor(0x6699FF)
write("  OCInit ")
term.setTextColor(0xFFFFFF)
write("starting up ")
term.setTextColor(0xFFFF00)
write(kernel.version().."\n\n")
term.setTextColor(0xFFFFFF)
-- /Messy

kernel.log("Starting init services")
local initd = fs.list("/etc/init.d")
table.sort(initd)
for i=1, #initd, 1 do
  kernel.log("Loading /etc/init.d/" .. initd[i])
  local ok, err = loadfile("/etc/init.d/" .. initd[i])
  if not ok then
    panic(err)
  end
  ok()
end

kernel.log("Starting shell")
while true do
  local ok, err = loadfile("/bin/sh.lua")
  if not ok then
    printError(err)
    break
  else
    ok()
  end
end
