local room, super = Class(Map)

function room:load()
  super:load(self)
  --print("room " .. self.name .. " loaded!")

end

return room
