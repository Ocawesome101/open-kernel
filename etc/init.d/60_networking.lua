-- Network management. --
-- I'm really liking this init system I've got going here :D --

local version = "Open Networks 0.0.1"
local hostname = dofile("/etc/hostname.lua")

network = {}

function network.hostname()
  return hostname
end
