-- Filesystem API wrapper-ish-kinda-sorta thing --

local oldOpen = fs.open
local oldClose = fs.close
local oldRead = fs.read
local oldWrite = fs.write

fs.close, fs.read, fs.write = nil, nil, nil

function fs.open(file, mode)
  if not fs.exists(file) then
    return false
  end
  local handle = oldOpen(file, mode)
  local rtn = {}
  function rtn.read(amount)
    return oldRead(handle, amount)
  end
  function rtn.readAll()
    local r = ""
    repeat
      local data = oldRead(handle, 0xFFFF) -- If you've got a file larger than 64K you're insane. Literally.
      r = r .. (data or "")
    until not data
    return r
  end
  function rtn.write(data)
    oldWrite(handle, data)
  end
  function rtn.close()
    return oldClose(handle)
  end
  return rtn
end
