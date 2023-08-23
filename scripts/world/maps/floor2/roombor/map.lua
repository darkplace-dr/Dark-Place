local mymap, super = Class(Map)

function mymap:onEnter()
    super.onEnter(self)
    Game.world:spawnObject(CloudsBG(0, 0), "objects_bg")

    local function disableVortex()
        Game.world.map:getEvent("timevortex"):remove()
        Game.world.map:getEvent(42):remove()
    end

    local flag = Game:getFlag("cloudwebStoryFlag", 0)
    if flag == 0 or flag == 1 then
        if Game.world:getCharacter("susie") then
            if Game.world:getCharacter("YOU") then
                if Game.world:getCharacter("kris") then
                    disableVortex()
                end
            else
                disableVortex()
            end
        else
            disableVortex()
        end
    else
        disableVortex()
    end
end

return mymap