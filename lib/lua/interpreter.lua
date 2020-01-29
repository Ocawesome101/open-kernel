local env = ...

term.setTextColor(colors.white)
write(_VERSION .. "> ")
local cmd = read()
load(cmd, "=lua", "bt", env)
