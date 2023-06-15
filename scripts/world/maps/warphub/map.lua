local WarpHub, super = Class(Map)

function WarpHub:onEnter()
    super.onEnter(self)

    Game.world:spawnObject(SpaceBG(), "objects_bg")
end

function WarpHub:onFootstep(char, num)
    local brandon = Game.world:getCharacter("brandon")
    if brandon then
        local brandon_party = Game:getPartyMember("brandon")
        if brandon_party.love >= 5 then
            local rand = math.random(1, 1000)
            if rand == 55 then
                if not Game:getFlag("thoughts") then
                    Game.world:startCutscene("thoughts", "b")
                end
            end
        end
    end
end

return WarpHub