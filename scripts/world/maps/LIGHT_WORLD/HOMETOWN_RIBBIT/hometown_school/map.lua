local room, super = Class(Map)

function room:load()
  super.load(self)
  print("room " .. self.name .. " loaded!")

--[[]

  local flag = Game:getFlag("TemplateFlag", default)

  if flag == false or flag == default then

    Game.world:startCutscene(function(cutscene)

      --Game:setFlag("TemplateFlag", true)

      cutscene:endCutscene()

    end)




  end
--]]
end

return room
