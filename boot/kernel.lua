-- A kernel. --
-- (c) 2020 Ocawesome101

local KERNEL_VERSION = "Open Kernel 0.5.0"

-- Set up proxy stuff
fs = component.proxy(component.invoke(component.list("eeprom")(), "getData"))

function loadfile(file)
  local h = fs.open(file, "r")
  if not h then
    return false, file .. ": file not found"
  end
  local buffer = ""
  repeat
    local data = fs.read(h, math.huge)
    buffer = buffer .. (data or "")
  until not data
  fs.close(h)
  return load(buffer, "="..file, "bt", _G)
end

-- Load convenience stuff
local ok, err = loadfile("/boot/libs/term.lua")
if not ok then error(err) end
ok()

term.clear()
term.setTextColor(0xFFFFFF)
term.write("kernel startup: phase 0")
local x,y = term.getCursorPos()
term.setCursorPos(1,y+1)

-- Write stuff
function write(str)
  local str = str or ""
  local x, y = term.getCursorPos()
  local w, h = term.getSize()
  
  local function newline()
    if y == h then
      term.scroll()
      term.setCursorPos(1,y)
    else
      term.setCursorPos(1,y+1)
    end
  end
  
  for c in str:gmatch(".") do
    x, y = term.getCursorPos()
    if c == "\n" then
      newline()
    else
      if x == w+1 then
        newline()
      elseif y == h then
        term.scroll()
        term.setCursorPos(1,y-1)
      end
      term.write(c)
    end
  end
end

function print(...)
  local toPrint = {...} or {""}
  for i=1, #toPrint, 1 do
    write(tostring(toPrint[i]))
    if i < #toPrint then
      write(" ")
    end
  end
  write("\n")
end

local uptime = computer.uptime
local function time() -- Properly format the computer's uptime for printing
  local r = tostring(uptime())
  local c,_ = r:find("%.")
  local c = c or 4
  if #r > 7 then -- Truncate to 7 characters
    r = r:sub(1,7)
  end
  if c < 4 then
    r = string.rep("0",4-c) .. r
  elseif c > 4 then
    r = r .. string.rep("0",c-4)
  end
  while #r < 7 do
    r = r .. "0"
  end
  return r
end

local function status(msg)
  print("[" .. time() .. "] " .. msg)
end

local reasons = {
  "Kernel panicking? I INVENTED kernel panicking!",
  "Run away! RUN AWAAAAAAY!",
  "No reason was given. Strange.",
  "Too many secrets",
  "This kernel was made by Ocawesome101"
}

local function panic(reason)
  local reason = reason or reasons[math.random(1,5)]
  local w,h = term.getSize()
  print(("="):rep(w))
  status("KERNEL PANIC: " .. reason)
  status("Press S to shut down your computer.")
  print(("="):rep(w))
  while true do
    local e, _, id = computer.pullSignal()
    if e == "key_down" and string.char(id) == "s" then
      computer.shutdown(false)
    end
  end
end

status("Kernel startup: phase 1")
status("Initialized loadfile")
status("Initialized term.*, write(), and print()")
status("Loading filesystem API from /lib/filesystem.lua")
local ok, err = loadfile("/boot/libs/filesystem.lua")
if not ok then
  panic(err)
end
ok()

status("Reinitializing loadfile")
function loadfile(file)
  local handle = fs.open(file, "r")
  if not handle then
    return false, file .. ": file not found"
  end
  local data = handle.readAll()
  return load(data, "=" .. file, "bt", _G)
end

status("Kernel startup: stage 2")

status("Setting up kernel hooks")
_G.kernel = {}
kernel.log = status
kernel.version = function()return KERNEL_VERSION end
kernel.shutdown = computer.shutdown

status("Loading init from /sbin/init.lua")
local ok, err = loadfile("/sbin/init.lua")
if not ok then
  panic(err)
end
ok(panic)
