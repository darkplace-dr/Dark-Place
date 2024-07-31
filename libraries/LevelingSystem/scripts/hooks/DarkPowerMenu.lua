---@class DarkPowerMenu
local DarkPowerMenu, super = Class("DarkPowerMenu", true)

function DarkPowerMenu:init()
    super.init(self)

    self.leveling_use_global_values = Kristal.getLibConfig("leveling", "global_love")

    self.data_shown = "spells"

    self.caption_sprites["experience"] = Assets.getTexture("ui/menu/caption_exp")
    self.caption_sprites["combos"] = Assets.getTexture("ui/menu/caption_combo")
    self.caption_sprites["arrow_l"] = Assets.getTexture("ui/flat_arrow_left_opaque")
    self.caption_sprites["arrow_r"] = Assets.getTexture("ui/flat_arrow_right_opaque")
end

--[[function DarkPowerMenu:getSpellLimit()
    return 3
end]]

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
            super.update(self)
        end
    elseif self.state == "CHOOSETAB" then
        if Input.pressed("cancel") then
            self.state = "PARTY"

            self.party.focused = true

            self.ui_cancel_small:stop()
            self.ui_cancel_small:play()
            return
        elseif Input.pressed("right") then
            self.ui_move:stop()
            self.ui_move:play()

            if self.data_shown == "spells" then self.data_shown = "experience"
            elseif self.data_shown == "experience" then self.data_shown = "combos"
            elseif self.data_shown == "combos" then self.data_shown = "spells" end
        elseif Input.pressed("left") then
            self.ui_move:stop()
            self.ui_move:play()

            if self.data_shown == "spells" then self.data_shown = "combos"
            elseif self.data_shown == "combos" then self.data_shown = "experience"
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
			elseif self.data_shown == "combos" and #self.party:getSelected():getCombos() > 0 then
                self.ui_select:stop()
                self.ui_select:play()
                if #self:getSpells() > 0 then
                    self.state = "COMBOS"

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
            super.update(self)
        end
	elseif self.state == "COMBOS" then
        if Input.pressed("cancel") then
            self.state = "CHOOSETAB"

            self.ui_cancel_small:stop()
            self.ui_cancel_small:play()

            self.scroll_y = 1

            self:updateDescription()
            return
        end
        local spells = self:getCombos()
        local old_selected = self.selected_spell
        if Input.pressed("up", true) then
            self.selected_spell = self.selected_spell - 1
        end
        if Input.pressed("down", true) then
            self.selected_spell = self.selected_spell + 1
        end
        self.selected_spell = Utils.clamp(self.selected_spell, 1, #spells)
        if self.selected_spell ~= old_selected then
            local spell_limit = self:getSpellLimit()
            local min_scroll = math.max(1, self.selected_spell - (spell_limit - 1))
            local max_scroll = math.min(math.max(1, #spells - (spell_limit - 1)), self.selected_spell)
            self.scroll_y = Utils.clamp(self.scroll_y, min_scroll, max_scroll)

            self.ui_move:stop()
            self.ui_move:play()
            self:updateDescription()
        end
    else
        super.update(self)
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
    elseif self.data_shown == "experience" then
        x = 265
        y = 218-14
        offset = 91+95
    else
        x = 298
        y = 98
        offset = 91+28
    end

    local arrow_weave = 0
    if self.state == "CHOOSETAB" then
        arrow_weave = Utils.round(math.sin(Kristal.getTime() * 5)) * 2
        Draw.setColor(1, 1, 0, 1)
    end
    Draw.draw(self.caption_sprites["arrow_l"], x-19-arrow_weave, 95, 0, 2, 2)
    Draw.draw(self.caption_sprites["arrow_r"], x+offset+arrow_weave, 95, 0, 2, 2)
    if self.state == "CHOOSETAB" then
        Draw.setColor(1, 1, 1, 1)
    end

    Draw.draw(self.caption_sprites[self.data_shown], x, 98, 0, 2, 2)

    self:drawChar()
    self:drawStats()
    if self.data_shown == "spells" then
        self:drawSpells()
    elseif self.data_shown == "experience" then
        self:drawExperience()
    else
        self:drawCombos()
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
    love.graphics.print( "LOVE:",   242-6,  122)
    love.graphics.print(  "EXP:",   242-6,  156)
    love.graphics.print( "NEXT:",   242-6,  190)
    love.graphics.print("KILLS:",   242-6,  224)

    love.graphics.print(               self:getLOVE(),  242+64, 122)
    love.graphics.print(                self:getExp(),  242+49, 156)
    love.graphics.print(             self:getNextLv(),  242+62, 190)
    love.graphics.print(Game:getFlag("library_kills"),  242+76, 224)
end

function DarkPowerMenu:drawCombos()
    local combos = self:getCombos()

    local tp_x, tp_y
    local name_x, name_y

    if #combos <= 6 then
        tp_x, tp_y = 258, 118
        name_x, name_y = 328, 118
    else
        tp_x, tp_y = 242, 118
        name_x, name_y = 302, 118
    end

    Draw.setColor(1, 1, 1)
    Draw.draw(self.tp_sprite, tp_x, tp_y - 5)

    local spell_limit = self:getSpellLimit()

    for i = self.scroll_y, math.min(#combos, self.scroll_y + (spell_limit - 1)) do
        local spell = combos[i]
        local offset = i - self.scroll_y

        Draw.setColor(0.5, 0.5, 0.5)
        love.graphics.print(tostring(spell:getTPCost(self.party:getSelected())).."%", tp_x, tp_y + (offset * 25))
        love.graphics.print(spell:getName(), name_x, name_y + (offset * 25))
    end

    -- Draw scroll arrows if needed
    if #combos > spell_limit then
        Draw.setColor(1, 1, 1)

        -- Move the arrows up and down only if we're in the spell selection state
        local sine_off = 0
        if self.state == "COMBOS" then
            sine_off = math.sin((Kristal.getTime()*30)/12) * 3
        end

        if self.scroll_y > 1 then
            -- up arrow
            Draw.draw(self.arrow_sprite, 469, (name_y + 25 - 3) - sine_off, 0, 1, -1)
        end
        if self.scroll_y + spell_limit <= #combos then
            -- down arrow
            Draw.draw(self.arrow_sprite, 469, (name_y + (25 * spell_limit) - 12) + sine_off)
        end
    end

    if self.state == "COMBOS" then
        Draw.setColor(Game:getSoulColor())
        Draw.draw(self.heart_sprite, tp_x - 20, tp_y + 10 + ((self.selected_spell - self.scroll_y) * 25))

        -- Draw scrollbar if needed (unless the spell limit is 2, in which case the scrollbar is too small)
        if spell_limit > 2 and #combos > spell_limit then
            local scrollbar_height = (spell_limit - 2) * 25
            Draw.setColor(0.25, 0.25, 0.25)
            love.graphics.rectangle("fill", 473, name_y + 30, 6, scrollbar_height)
            local percent = (self.scroll_y - 1) / (#combos - spell_limit)
            Draw.setColor(1, 1, 1)
            love.graphics.rectangle("fill", 473, name_y + 30 + math.floor(percent * (scrollbar_height-6)), 6, 6)
        end
    end
end


function DarkPowerMenu:canCast(spell)
    if not Game:getFlag("tension_storage") then return false end
    if Game:getTension() < spell:getTPCost(self.party:getSelected()) then return false end

    return spell:hasWorldUsage(self.party:getSelected())
end

function DarkPowerMenu:updateDescription()
    if self.state == "SPELLS" then
        local spell = self:getSpells()[self.selected_spell]
        Game.world.menu:setDescription(spell and spell:getDescription() or "", true)
    elseif self.state == "COMBOS" then
        local combo = self:getCombos()[self.selected_spell]
        Game.world.menu:setDescription(combo and combo:getDescription() or "", true)
    else
        Game.world.menu:setDescription("", false)
    end
end

function DarkPowerMenu:getCombos()
    local combos = {}
    local party = self.party:getSelected()
    for _,combo in ipairs(party:getCombos()) do
        table.insert(combos, combo)
    end
    return combos
end

return DarkPowerMenu