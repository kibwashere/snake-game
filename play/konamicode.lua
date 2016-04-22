--This file checks the konami code activation
--https://love2d.org/forums/viewtopic.php?f=4&t=75240

local mt = {
   __index = function(table, key)
      local value = getfenv(0)[key]
      rawset(table, key, value)
      return value
   end
}
local env = setmetatable({}, mt)
setfenv(1, env)

code = {"up", "up", "down", "down", "left", "right", "left", "right", "b", "a"}
progress = 0

function keypressed(key)
   if key == code[progress + 1] then
      progress = progress + 1
      if progress == #code then
         callback()
         progress = 0
      end
   else
      progress = 0
   end
end

return function(func)
   callback = func
   return env
end