-- Better tables --

function table.new(items)
  local returnTable = items or {}
  setmetatable(returnTable, {__index=table}) --Why this isn't just done by default for all tables I have no idea.
  return returnTable
end
