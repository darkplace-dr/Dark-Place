---@diagnostic disable: redundant-return-value
local lib = {}

function lib:postInit()
    Utils.hook(DarkPowerMenu, "drawStats", function(orig, self)
        local party = self.party:getSelected()

        if party.ribbit == true then
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.draw(self.stat_icons["attack"], -8, 124, 0, 2, 2)
            love.graphics.draw(Assets.getTexture("ui/menu/icon/placebo"), -8, 149, 0, 2, 2)
            love.graphics.draw(self.stat_icons["magic"], -8, 174, 0, 2, 2)
            love.graphics.print("Attack:", 18, 118)
            love.graphics.print("Placebo:", 18, 143)
            love.graphics.print("Magic:", 18, 168)
            local stats = party:getStats()
            love.graphics.print(stats["attack"], 148, 118)
            love.graphics.print(stats["defense"], 148, 143)
            love.graphics.print(stats["magic"], 148, 168)
            for i = 1, 3 do
                local x, y = 18, 168 + (i * 25)
                love.graphics.setFont(self.font)
                love.graphics.setColor(PALETTE["world_text"])
                love.graphics.push()
                if not party:drawPowerStat(i, x, y, self) then
                    love.graphics.setColor(PALETTE["world_dark_gray"])
                    love.graphics.print("???", x, y)
                end
                love.graphics.pop()
            end
        else
            orig(self)
        end
    end)

    Utils.hook(DarkEquipMenu, "drawStats", function(orig, self)
        local party = self.party:getSelected()

        if party.ribbit == true then
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.draw(self.stat_icons["attack"], -8, 124, 0, 2, 2)
            love.graphics.draw(Assets.getTexture("ui/menu/icon/placebo"), -8, 151, 0, 2, 2)
            love.graphics.draw(self.stat_icons["magic"], -8, 178, 0, 2, 2)
            love.graphics.print("Attack:", 18, 118)
            love.graphics.print("Placebo:", 18, 145)
            love.graphics.print("Magic:", 18, 172)
            local stats, compare = self:getStatsPreview()
            self:drawStatPreview("attack", 148, 118, stats, compare)
            self:drawStatPreview("defense", 148, 145, stats, compare)
            self:drawStatPreview("magic", 148, 172, stats, compare)
            local abilities, ability_comp = self:getAbilityPreview()
            for i = 1, 3 do
                self:drawAbilityPreview(i, -8, 178 + (27 * i), abilities, ability_comp)
            end
        else
            orig(self)
        end
    end)

    Utils.hook(DarkEquipMenu, "drawAbilityPreview", function(orig, self, index, x, y, abilities, compare)
        local party = self.party:getSelected()

        if party.ribbit == true then
            local name = abilities[index] and abilities[index].name or nil
            local comp_name = compare[index] and compare[index].name or nil
            if abilities[index] and abilities[index].icon then
                local yoff = self.state == "ITEMS" and -6 or 2
                local texture = Assets.getTexture(abilities[index].icon)
                if texture then
                    love.graphics.setColor(255 / 255, 160 / 255, 64 / 255)
                    love.graphics.draw(texture, x, y + yoff, 0, 2, 2)
                end
            end
            if name ~= comp_name then
                if name ~= nil then
                    love.graphics.setColor(1, 1, 0)
                else
                    love.graphics.setColor(1, 0, 0)
                end
            else
                if (name and self.state ~= "ITEMS") or (self.state == "ITEMS" and self.selected_slot == index and self:canEquipSelected()) then
                    love.graphics.setColor(1, 1, 1)
                else
                    love.graphics.setColor(0.25, 0.25, 0.25)
                end
            end
            if self.state == "ITEMS" then
                love.graphics.print(name or "(OR MAYBE NOT?)", x + 26, y - 6)
            else
                love.graphics.print(name or "(NOTHING HERE)", x + 26, y - 6)
            end
        else
            orig(self, index, x, y, abilities, compare)
        end
    end)

    --///////////////// ACTION BUTTONS

    Utils.hook(ActionButton, "select", function(orig, self)
        if self.type == "send" then
            Game.battle:setState("ENEMYSELECT", "SPARE")
        else
            orig(self)
        end
    end)
    Utils.hook(ActionButton, "hasSpecial", function(orig, self)
        if self.type == "send" then
            for _,enemy in ipairs(Game.battle:getActiveEnemies()) do
                if enemy.mercy >= 100 then
                    return true
                end
            end
            return false
        else
            return orig(self)
        end
    end)
    Utils.hook(EnemyBattler, "getSpareText", function(orig, self, battler, success)
        local text = orig(self, battler, success)
        if Game:getPartyMember(battler.chara.id).ribbit then
            if type(text)=="table" then
                --text[1] = text[1]:gsub("spared", "SENT")
                
                if success == true then
                    text[1] = "* " .. battler.chara:getName() .. " SENT " .. self.name .. "!"
                else
                    text[1] = "* " .. battler.chara:getName() .. " SENT " .. self.name .. "!\n* But it wasn't [color:yellow]APPEASED[color:reset]..."
                end
            else
                --text = text:gsub("spared", "SENT")
                if success == true then
                    text = "* " .. battler.chara:getName() .. " SENT " .. self.name .. "!"
                else
                    text = "* " .. battler.chara:getName() .. " SENT " .. self.name .. "!\n* But it wasn't [color:yellow]APPEASED[color:reset]..."
                end
            end
        end
        return text
    end)
end

function lib:getActionButtons(battler, buttons)
    if Game:getPartyMember(battler.chara.id).ribbit then
        if Game:getPartyMember(battler.chara.id).name == "YOU" then
            return {"fight", "act", "item", "send", "defend"}
        else
            return {"fight", "magic", "item", "send", "defend"}
        end
    end
    return buttons
end

return lib