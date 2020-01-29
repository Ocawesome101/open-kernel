-- Stuff --

local ok, err = loadfile("/lib/colors.lua")
if not ok then
  kernel.log("Error " .. err .. "while loading /lib/colors.lua")
  return
end
ok()

function sleep(time)
  local done = computer.uptime() + time
  repeat
    computer.pullSignal(time - computer.uptime())
  until computer.uptime() >= done
end
