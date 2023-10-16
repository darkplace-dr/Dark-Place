local UT2Button, super = Class(ActionButton)

function UT2Button:init()
    super.init(self, "ut2_act")
end

function UT2Button:update()
    self:setColor(1,1,1)

    super.update(self)
end

-- function UT2Button:select()
--     self:explode()
--     Mod.dog_activated = false
--     Game.battle.music:stop()
--     for _,box in ipairs(Game.battle.battle_ui.action_boxes) do
--         box:createButtons()
--     end
-- end

return UT2Button