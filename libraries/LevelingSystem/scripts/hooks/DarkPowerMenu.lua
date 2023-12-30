---@class DarkPowerMenu
local DarkPowerMenu, super = Class("DarkPowerMenu", true)

function DarkPowerMenu:init()
    super.init(self)

    self.leveling_use_global_values = Kristal.getLibConfig("leveling", "global_love")

    self.data_shown = "spells"

    self.caption_sprites["experience"] = Assets.getTexture("ui/menu/caption_exp")
    self.caption_sprites["arrow_l"] = Assets.getTexture("ui/menu/arrow_left")
    self.caption_sprites["arrow_r"] = Assets.getTexture("ui/menu/arrow_right")
end

--function DarkPowerMenu:getSpellLimit()
--    return 3
--end

--[[function DarkPowerMenu:draw()
    love.graphics.setFont(self.font)

    Draw.setColor(PALETTE["world_border"])
    love.graphics.rectangle("fill", 216, 224-14, 285, 6)

    Draw.setColor(1, 1, 1, 1)
    Draw.draw(self.caption_sprites["experience"], 265,  218-14, 0, 2, 2)

    self:drawExperience()

    super.draw(self)
end]]

function DarkPowerMenu:update()
    if self.state == "PARTY" then
        if Input.pressed("confirm") then
            self.state = "CHOOSETAB"

            self.party.focused = false

            self.ui_select:stop()
            self.ui_select:play()
        else
            super:update(self)
        end
    elseif self.state == "CHOOSETAB" then
        if Input.pressed("cancel") then
            self.state = "PARTY"

            self.party.focused = true

            self.ui_cancel_small:stop()
            self.ui_cancel_small:play()
            return
        elseif Input.pressed("left") or Input.pressed("right") then
            self.ui_move:stop()
            self.ui_move:play()

            if self.data_shown == "spells" then self.data_shown = "experience"
            elseif self.data_shown == "experience" then self.data_shown = "spells" end
        elseif Input.pressed("confirm") then
            if self.data_shown == "spells" then
                self.ui_select:stop()
                self.ui_select:play()
                if #self:getSpells() > 0 then
                    self.state = "SPELLS"

                    self.party.focused = false

                    self.selected_spell = 1
                    self.scroll_y = 1

                    self:updateDescription()
                end
            end
        end
    elseif self.state == "SPELLS" then
        if Input.pressed("cancel") then
            self.state = "CHOOSETAB"

            self.ui_cancel_small:stop()
            self.ui_cancel_small:play()

            self.scroll_y = 1

            self:updateDescription()
            return
        else
            super:update(self)
        end
    else
        super:update(self)
    end
end

function DarkPowerMenu:draw()
    love.graphics.setFont(self.font)

    Draw.setColor(PALETTE["world_border"])
    love.graphics.rectangle("fill", -24, 104, 525, 6)
    if Game:getConfig("oldUIPositions") then
        love.graphics.rectangle("fill", 212, 104, 6, 196)
    else
        love.graphics.rectangle("fill", 212, 104, 6, 200)
    end

    Draw.setColor(1, 1, 1, 1)
    Draw.draw(self.caption_sprites[  "char"],  42, -28, 0, 2, 2)
    Draw.draw(self.caption_sprites[ "stats"],  42,  98, 0, 2, 2)

    local x, y, offset
    if self.data_shown == "spells" then
        x = 298
        y = 98
        offset = 91+28
    else
        x = 265
        y = 218-14
        offset = 91+95
    end
    if self.state == "CHOOSETAB" then
        Draw.setColor(1, 1, 0, 1)
    end
    Draw.draw(self.caption_sprites["arrow_l"], x-19, 96, 0, 2, 2)
    Draw.draw(self.caption_sprites["arrow_r"], x+offset, 96, 0, 2, 2)
    if self.state == "CHOOSETAB" then
        Draw.setColor(1, 1, 1, 1)
    end

    Draw.draw(self.caption_sprites[self.data_shown], x, 98, 0, 2, 2)

    self:drawChar()
    self:drawStats()
    if self.data_shown == "spells" then
        self:drawSpells()
    else
        self:drawExperience()
    end

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

function DarkPowerMenu:drawExperience()
    Draw.setColor(1, 1, 1, 1)
    love.graphics.print( "LOVE:",   242-6, 122)
    love.graphics.print( "EXP:",    242-6, 156)
    love.graphics.print( "NEXT:",   242-6, 190)
    love.graphics.print( "KILLS:",  242-6, 224)

    love.graphics.print(self:getLOVE(),   242+64, 122)
    love.graphics.print(self:getExp(), 242+49, 156)
    love.graphics.print(self:getNextLv(), 242+62, 190)
    love.graphics.print(Game:getFlag("library_kills"),  242+76, 224)
    
end


function DarkPowerMenu:canCast(spell)
    if not Game:getFlag("tension_storage") then return false end
    if Game:getTension() < spell:getTPCost(self.party:getSelected()) then return false end

    return (spell:hasWorldUsage(self.party:getSelected()))
end

function DarkPowerMenu:updateDescription()
    if self.state == "SPELLS" then
        local spell = self:getSpells()[self.selected_spell]
        Game.world.menu:setDescription(spell and spell:getDescription() or "", true)
    else
        Game.world.menu:setDescription("", false)
    end
end


return DarkPowerMenu