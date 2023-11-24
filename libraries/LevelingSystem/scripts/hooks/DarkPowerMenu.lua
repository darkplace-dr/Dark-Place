---@class DarkPowerMenu
local DarkPowerMenu, super = Class("DarkPowerMenu", true)

function DarkPowerMenu:init()
    super.init(self)

    self.leveling_use_global_values = Kristal.getLibConfig("leveling", "global_love")
end

function DarkPowerMenu:draw()
    love.graphics.setFont(self.font)

    love.graphics.setColor(PALETTE["world_border"])
    love.graphics.rectangle("fill", -24, 104, 525, 6)
    love.graphics.rectangle("fill", 212, 104, 6, 200)
    love.graphics.rectangle("fill", 212, 240, 285, 6)

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(self.caption_sprites[  "char"],  42, -28, 0, 2, 2)
    love.graphics.draw(self.caption_sprites[ "stats"],  42,  98, 0, 2, 2)
    love.graphics.draw(self.caption_sprites["spells"], 298,  98, 0, 2, 2)

    self:drawChar()
    self:drawStats()
    self:drawSpells()
    self:drawExp()

    super.super.draw(self)
end

function DarkPowerMenu:getExp()
    return self.leveling_use_global_values
        and Game:getFlag("library_experience")
        or self.party:getSelected():getExp()
end

function DarkPowerMenu:getNextLv()
    return self.leveling_use_global_values
        and Kristal.callEvent("getGlobalNextLv")
        or self.party:getSelected():getNextLv()
end

function DarkPowerMenu:getLOVE()
    return self.leveling_use_global_values
        and Game:getFlag("library_love")
        or self.party:getSelected():getLOVE()
end

function DarkPowerMenu:drawExp()
    love.graphics.setColor(1, 1, 1)
    love.graphics.print("LOVE:", 225, 240)
    love.graphics.print(self:getLOVE(), 290, 240)
    love.graphics.print("EXP:", 225, 265)
    love.graphics.print(self:getExp(), 275, 265)
    love.graphics.print("Next:", 350, 265)
    love.graphics.print(self:getNextLv(), 415, 265)
    love.graphics.print("Kills:", 350, 240)
    love.graphics.print(Game:getFlag("library_kills"), 429, 240)
end


function DarkPowerMenu:canCast(spell)
    if not Game:getFlag("tension_storage") then return false end
    if Game:getTension() < spell:getTPCost(self.party:getSelected()) then return false end

    return (spell:hasWorldUsage(self.party:getSelected()))
end


return DarkPowerMenu