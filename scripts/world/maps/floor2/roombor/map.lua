local mymap, super = Class(Map)

function mymap:onEnter()
    super.onEnter(self)
    Game.world:spawnObject(CloudsBG(0, 0), "objects_bg")

    local flag = Game:getFlag("cloudwebStoryFlag", df)
    if flag == df or flag == 0 or flag == 1 then
        if Game.world:getCharacter("susie") then
            if Game.world:getCharacter("YOU") then
                if Game.world:getCharacter("kris") == nil then
                else
                    Game.world.map:getEvent("timevortex"):remove()
                    Game.world.map:getEvent(42):remove()
                end
            else
                Game.world.map:getEvent("timevortex"):remove()
                Game.world.map:getEvent(42):remove()
            end
        else
            Game.world.map:getEvent("timevortex"):remove()
            Game.world.map:getEvent(42):remove()
        end
    else
        Game.world.map:getEvent("timevortex"):remove()
        Game.world.map:getEvent(42):remove()
    end
end

return mymap