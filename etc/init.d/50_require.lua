-- dofile() and require() -- 

local requirePath = "/lib/require:/lib"

local ok, err = loadfile("/lib/tokenize.lua")
if not ok then
  printError(err)
  return false, err
end
local tokenize = ok()

function dofile(file, ...)
  local ok, err = loadfile(file)
  if not ok then
    printError(err)
    return false, err
  end
  return ok(...)
end

function require(lib)
  local paths = tokenize(requirePath, ":")
  for i=1, #paths, 1 do
    if fs.exists(paths[i] .. "/" .. lib .. ".lua") then
      return dofile(paths[i] .. "/" .. lib .. ".lua")
    elseif fs.exists(paths[i] .. "/" .. lib .. "/" .. lib .. ".lua") then
      return dofile(paths[i] .. "/" .. lib .. "/" .. lib .. ".lua")
    elseif fs.exists(paths[i] .. "/" .. lib .. "/init.lua") then
      return dofile(paths[i] .. "/" .. lib .. "/init.lua")
    end
  end
  printError("Could not find " .. lib)
  return false
end
