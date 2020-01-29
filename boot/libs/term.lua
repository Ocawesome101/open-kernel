-- A term API very similar to ComputerCraft's. --

-- GPU and screen proxies --
_G.gpu = component.list("gpu")()
local screen = component.list("screen")()

component.invoke(gpu, "bind", screen)
gpu = component.proxy(gpu)

local w,h = gpu.maxResolution()
local x,y = 1,1
gpu.setResolution(w,h)
local cursorVisible = false

local function update() -- Force a screen refresh
  computer.pullSignal(0)
end

_G.term = {}

function term.clearLine()
  gpu.set(1,y,(" "):rep(w))
  update()
end

function term.clear()
  gpu.fill(1,1,w,h," ")
  update()
end

function term.getCursorPos()
  return x, y
end

function term.setCursorPos(newX,newY)
  if type(newX) == "number" and type(newY) == "number" then
    x = newX
    y = newY
  else
    return
  end
end

function term.getBackgroundColor()
  return gpu.getBackground()
end

function term.setBackgroundColor(color)
  return gpu.setBackground(color)
end

function term.getTextColor()
  return gpu.getForeground()
end

function term.setTextColor(color)
  return gpu.setForeground(color)
end

term.getPaletteColor = gpu.getPaletteColor
term.setPaletteColor = gpu.setPaletteColor

function term.isColor() -- Returns true or false and the color depth
  local depth = gpu.maxDepth()
  if depth == 1 then
    return false, 1
  else
    return true, depth
  end
end

function term.setSize(newW,newH)
  if type(newW) == "number" and type(newH) == "number" then
    return gpu.setResolution(newW, newH)
  end
end

function term.getSize()
  return gpu.getResolution()
end

function term.maxSize()
  return gpu.maxResolution()
end

function term.write(str)
  gpu.set(x,y,str)
  x = x + #str
end

function term.scroll()
  gpu.copy(1,2,w,h-1,0,-1)
  gpu.fill(1,h,w,1," ")
  update()
end

function term.update()
  update()
end
