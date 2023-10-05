local Chair_Room, super = Class(Map)

function Chair_Room:onEnter()
    self.has_gonergirl = Game:getFlag("gonergirl", false)
    Game:setFlag("gonergirl", nil)

    if self.has_gonergirl and not Game:setFlag("seen_gonergirl", false) then
        --Game:setFlag("seen_gonergirl", true)
        local shimai = Sprite("world/npcs/gonergirl/lower_hands_1", 30, 14)
        local chair = Game.world:getEvent(9)
        shimai:setScale(2)
        chair.girl = shimai
        chair.custom_cutscene = "gonergirl"
        chair:addChild(shimai)
    end
    for i,v in ipairs(Game.world.followers) do
        v:remove()
    end

    local transition = Game.world.map:getEvent("transition")
    if transition then
        transition.target.map = Mod.lastMap
    end
end

return Chair_Room