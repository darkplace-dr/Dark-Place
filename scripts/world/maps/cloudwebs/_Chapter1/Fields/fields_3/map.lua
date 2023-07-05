local room, super = Class(Map)

function room:load()
  super:load(self)
  --print("room " .. self.name .. " loaded!")
  if not Game:getFlag("chapter1_seenfieldsmusiclogo", false) then
    Game.world:spawnObject(musiclogo("field2", 180 -3, 120, 160 -3, 120, 140 -3, 120), 9999)
    Game:setFlag("chapter1_seenfieldsmusiclogo", true)
  else
    if not Game:getFlag("chapter1_seenfieldsmusiclogo2", false) and Game:getFlag("chapter1_abletoseefieldsmusiclogo2", false) == true then
      Game.world:spawnObject(musiclogo("field3", 180, 120, 160, 120, 140, 120), 9999)
      Game:setFlag("chapter1_seenfieldsmusiclogo2", true)
    end
  end
end

return room
