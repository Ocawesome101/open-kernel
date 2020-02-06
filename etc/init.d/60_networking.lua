-- Network management. --
-- I'm really liking this init system I've got going here :D --

local version = "Open Networks 0.0.1"
local hostname = fs.getLabel()

kernel.log("Checking for an internet card")
local internet = component.list("internet")()
if not internet then
  kernel.log("No internet card found")
else
  _G.internet = component.proxy(internet)
  kernel.log("Found internet card and created proxy")
end

network = {}

function network.hostname()
  return hostname
end

function network.setHostname(h)
  if type(h) == "string" then
    fs.setLabel(h)
    hostname = h
  end
end
