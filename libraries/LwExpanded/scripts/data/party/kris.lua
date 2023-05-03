local character, super = Class("kris", true)

function character:init()
    super:init(self)

    self.lw_health = 20

    self.lw_stats = {
        health = 20,
        attack = 10,
        defense = 1,
        magic = 0
    }
end 

-- This WOULD swap Kris's color and head icons in the light world, since they're not blue there.
-- But it only triggers in battle and I can't figure out how to get it to revert after battle, so I disabled it.
-- Uncomment this function to enable it if you want.

--[[
function character:onTurnStart(battler)

    if Game:isLight() then
        -- Character colors
        self.color = {154/255, 205/255, 50/255}
        self.dmg_color = nil
        self.attack_bar_color = nil
        self.attack_box_color = nil
        self.xact_color = nil
        -- Path to head icons used in battle
        self.head_icons = "party/kris/light/icon"
    else
        self.color = {0, 1, 1}
        self.dmg_color = {0.5, 1, 1}
        self.attack_bar_color = {0, 162/255, 232/255}
        self.attack_box_color = {0, 0, 1}
        self.xact_color = {0.5, 1, 1}

        self.head_icons = "party/kris/icon"
    end

end
--]]


return character