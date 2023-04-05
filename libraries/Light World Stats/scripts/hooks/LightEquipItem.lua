---@class _LightEquipItem : LightEquipItem
---@overload fun(...) : LightEquipItem
local LightEquipItem, super = Class("LightEquipItem", true)

function LightEquipItem:showEquipText(cutscene, chara)
    cutscene:text("* " .. chara:getName() .. " equipped the " .. self:getName() .. ".")
end

function LightEquipItem:onWorldUse(target)
    Game.world:startCutscene(function(cutscene)
        local char_id = 1
        if #Game.party > 1 then
            cutscene:text("* Who will equip the " .. self:getName() .. "?")
            local choices = {}
            for _, mem in ipairs(Game.party) do
                table.insert(choices, mem:getName())
            end
            char_id = cutscene:choicer(choices)
        end

        Assets.playSound("item")
        local chara = Game.party[char_id]
        local replacing = nil
        if self.type == "weapon" then
            if chara:getWeapon() then
                replacing = chara:getWeapon()
                replacing:onUnequip(chara, self)
                Game.inventory:replaceItem(self, replacing)
            end
            chara:setWeapon(self)
        elseif self.type == "armor" then
            if chara:getArmor(1) then
                replacing = chara:getArmor(1)
                replacing:onUnequip(chara, self)
                Game.inventory:replaceItem(self, replacing)
            end
            chara:setArmor(1, self)
        else
            error("LightEquipItem " .. self.id .. " invalid type: " .. self.type)
        end

        self:onEquip(chara, replacing)

        self:showEquipText(cutscene, chara)
        return false
    end)
end

return LightEquipItem