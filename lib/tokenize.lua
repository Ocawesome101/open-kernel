-- Yes, I'm American. -- 

local tokenize = function(str, sep) -- String, and the separator to look for in said string
  local words = table.new()
  local word = ""
  local sep = sep or " " -- The default separator is a space
  for c in str:gmatch(".") do
    if c == sep then
      words:insert(word)
      word = ""
    else
      word = word .. c
    end
  end
  if word ~= "" then -- If we didn't end on a separator
    words:insert(word)
    word = ""
  end
  return words
end

return tokenize
