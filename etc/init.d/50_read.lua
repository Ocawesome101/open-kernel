-- Do you read me? --

function read(replace, highlighter)
  local x,y = term.getCursorPos()
  local w,h = term.getSize()
  local str = ""
  
  local function redraw()
    term.setCursorPos(x,y)
    term.write((" "):rep(w - x))
    term.setCursorPos(x,y)
    term.write(str)
  end
end
