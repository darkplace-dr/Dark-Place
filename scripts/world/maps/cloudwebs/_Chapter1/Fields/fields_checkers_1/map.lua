local room, super = Class(Map)

function room:load()
  super:load(self)
  --print("room " .. self.name .. " loaded!")

  for _,pillarsBg1 in pairs(Game.world.map:getEvents("parallaxpeon")) do
    pillarsBg1.wrap_texture_x = true
    pillarsBg1.parallax_x = 0.9
    pillarsBg1.parallax_y = 1
  end

end

return room
