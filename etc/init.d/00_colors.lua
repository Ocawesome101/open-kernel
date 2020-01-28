-- Colors --
kernel.log("Loading colors API")
local ok, err = loadfile("/lib/colors.lua")
if not ok then
  kernel.log("Error " .. err .. "while loading /lib/colors.lua")
  return
end
ok()
