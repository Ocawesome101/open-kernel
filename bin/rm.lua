-- rm --

local args = {...}

if #args < 1 then
  error("usage: rm FILE1 FILE2 ...")
  return false
end

for i=1, #args, 1 do
  if fs.exists(shell.resolvePath(args[1])) then
    write("Really delete " .. args[1] .. "? [y/n] ")
    local yn = read()
    if yn:lower() == "y" then
      fs.remove(shell.resolvePath(args[1]))
    else
      print("Skipping")
    end
  else
    printError(args[1] .. ": No such file")
  end
end
