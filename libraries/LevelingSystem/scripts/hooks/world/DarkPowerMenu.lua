---@class DarkPowerMenu : Object
---@overload fun(...) : DarkPowerMenu
local DarkPowerMenu, super = Class(DarkPowerMenu, false)

function DarkPowerMenu:init()
    super.init(self)

    self.use_global_values = Kristal.getLibConfig("leveling", "global_love")
    self.love_global = Game:getFlag("library_love")
    self.experience_global = Game:getFlag("library_experience")
    self.nextlv_global = Game:getFlag("library_nextlv")
    self.kills = Game:getFlag("library_kills")
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
    return self.use_global_values
        and self.experience_global
        or self.party:getSelected():getExp()
end

function DarkPowerMenu:getNextLv()
    return self.use_global_values
        and self.nextlv_global
        or self.party:getSelected():getNextLv()
end

function DarkPowerMenu:drawExp()
    love.graphics.setColor(1, 1, 1)
    if self.use_global_values then
        love.graphics.print("LOVE:", 225, 240)
        love.graphics.print(self.love_global, 290, 240)
    end
    local exp = self:getExp()
    local next = self:getNextLv()
    love.graphics.print("EXP:", 225, 265)
    love.graphics.print(exp, 275, 265)
    love.graphics.print("Next:", 350, 265)
    love.graphics.print(next, 415, 265)
    love.graphics.print("Kills:", 350, 240)
    love.graphics.print(self.kills, 429, 240)
end

return DarkPowerMenu