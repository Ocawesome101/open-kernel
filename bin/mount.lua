-- disk mounter --

local args = {...} 

if args[1] and args[2] then
  fs.mount(args[1], args[2])
elseif args[1] then
  error("Missing arguments")
else
  local mnt = fs.mounts()
  for i=1, #mnt, 1 do
    print(mnt[i].addr, "mounted on", mnt[i].path)
  end
end
