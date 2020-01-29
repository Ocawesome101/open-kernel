-- cd --

local args = {...} 

if #args < 1 then
  shell.pwd = "/"
else
  local newPwd = shell.resolvePath(args[1])
  if fs.exists(newPwd) and fs.isDirectory(newPwd) then
    shell.pwd = newPwd
  else
    error(args[1] .. " is not a directory")
  end
end
