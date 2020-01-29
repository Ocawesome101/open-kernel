-- Shut down --

local args = {...} 

if #args < 1 then
  error("usage: shutdown -s|-r")
  return false
end

if args[1] == "-s" then
  kernel.log("Shutting down")
  term.update()
  sleep(1)
  computer.shutdown(false)
elseif args[1] == "-r" then
  kernel.log("Restarting")
  term.update()
  sleep(1)
  computer.shutdown(true)
end
