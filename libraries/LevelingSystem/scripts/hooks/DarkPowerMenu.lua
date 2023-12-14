---@class DarkPowerMenu
local DarkPowerMenu, super = Class("DarkPowerMenu", true)

function DarkPowerMenu:init()
    super.init(self)

    self.leveling_use_global_values = Kristal.getLibConfig("leveling", "global_love")

    self.caption_sprites["experience"] = Assets.getTexture("ui/menu/caption_exp")
end

function DarkPowerMenu:getSpellLimit()
    return 3
end

function DarkPowerMenu:draw()
    love.graphics.setFont(self.font)

    Draw.setColor(PALETTE["world_border"])
    love.graphics.rectangle("fill", 216, 224-14, 285, 6)

    Draw.setColor(1, 1, 1, 1)
    Draw.draw(self.caption_sprites["experience"], 265,  218-14, 0, 2, 2)

    self:drawExperience()

    super.draw(self)
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

function DarkPowerMenu:drawExperience()
    Draw.setColor(1, 1, 1, 1)
    love.graphics.print( "LOVE:",   242-6, 224)
    love.graphics.print( "EXP:",    242-6, 256)
    love.graphics.print( "NEXT:",   348, 224)
    love.graphics.print( "KILLS:",  348, 256)

    love.graphics.print(self:getLOVE(),   242+64, 224)
    love.graphics.print(self:getExp(), 242+64, 256)
    love.graphics.print(self:getNextLv(), 342+90, 224)
    love.graphics.print(Game:getFlag("library_kills"),  342+90, 256)
    
end

return DarkPowerMenu