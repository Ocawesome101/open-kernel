-- Event management --

event = {}

function event.pull(filter)
  local data = {computer.pullSignal()}
  if data[1] == filter then
    return table.unpack(data)
  end
end
