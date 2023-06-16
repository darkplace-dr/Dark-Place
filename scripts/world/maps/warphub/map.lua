local WarpHub, super = Class(Map)

function WarpHub:onEnter()
    super.onEnter(self)

    Game.world:spawnObject(SpaceBG(), "objects_bg")
end

function WarpHub:onFootstep(char, num)
    local brandon = Game.world:getCharacter("brandon")
    if (brandon and Game:getPartyMember("brandon").love >= 5)
        and (love.math.random(1, 1000) == 55 and not Game:getFlag("thoughts"))
    then
        Game.world:startCutscene("thoughts", "b")
    end
end

return WarpHub