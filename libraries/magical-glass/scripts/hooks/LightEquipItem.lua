local LightEquipItem, super = Class("LightEquipItem", true)

function LightEquipItem:init()
    super.init(self)
    
    self.index = nil
    self.storage = nil

    self.equip_display_name = nil

    self.target = "ally"

    self.heal_bonus = 0
    self.inv_bonus = 0

    self.light_bolt_count = 1

    self.light_bolt_speed = 11
    self.light_bolt_speed_variance = 2

    self.light_bolt_start = -16 -- number or table of where the bolt spawns. if it's a table, a value is chosen randomly
    self.light_multibolt_variance = 50

    self.light_bolt_direction = "right" -- "right", "left", or "random"

    self.light_bolt_miss_threshold = 280

    self.attack_sprite = "effects/attack/strike"

    -- Sound played when attacking, defaults to laz_c
    self.attack_sound = "laz_c"

    self.attack_pitch = 1
end

function LightEquipItem:getEquipDisplayName()
    if self.equip_display_name then
        return self.equip_display_name
    else
        return self:getName()
    end
end
function LightEquipItem:getFleeBonus() return 0 end

function LightEquipItem:applyHealBonus(value) return value + self.heal_bonus end
function LightEquipItem:applyInvBonus(value) return value + self.inv_bonus end

function LightEquipItem:getLightBoltCount() return self.light_bolt_count end

function LightEquipItem:getLightBoltSpeed()
    if Game.battle.multi_mode then
        return nil
    else
        return self.light_bolt_speed + Utils.random(0, self:getLightBoltSpeedVariance(), 1)
    end
end
function LightEquipItem:getLightBoltSpeedVariance() return self.light_bolt_speed_variance or 0 end

function LightEquipItem:getLightBoltStart()
    if Game.battle.multi_mode then
        return nil
    elseif type(self.light_bolt_start) == "table" then
        return Utils.pick(self.light_bolt_start)
    elseif type(self.light_bolt_start) == "number" then
        return self.light_bolt_start
    end
end

function LightEquipItem:onBattleSelect(user, target)
    self.storage, self.index = Game.inventory:getItemIndex(self)
    return true
end

function LightEquipItem:getLightMultiboltVariance(index)
    if Game.battle.multi_mode then
        return nil
    elseif type(self.light_multibolt_variance) == "number" then
        return self.light_multibolt_variance * index
    elseif self.light_multibolt_variance[index] then
        return type(self.light_multibolt_variance[index]) == "table" and Utils.pick(self.light_multibolt_variance[index]) or self.light_multibolt_variance[index]
    else
        return (type(self.light_multibolt_variance[#self.light_multibolt_variance]) == "table" and Utils.pick(self.light_multibolt_variance[#self.light_multibolt_variance]) or self.light_multibolt_variance[#self.light_multibolt_variance]) * (index - #self.light_multibolt_variance + 2) / 2
    end
end

function LightEquipItem:getLightBoltDirection() 
    if self.light_bolt_direction == "random" then
        return Utils.pick({"right", "left"})
    else
        return self.light_bolt_direction
    end
end

function LightEquipItem:getLightAttackMissZone() return self.light_bolt_miss_threshold end

function LightEquipItem:getLightAttackSprite() return self.attack_sprite end

function LightEquipItem:getLightAttackSound() return self.attack_sound end
function LightEquipItem:getLightAttackPitch() return self.attack_pitch end

function LightEquipItem:onTurnEnd() end

function LightEquipItem:showEquipText(target)
    Game.world:showText("* " .. target:getNameOrYou() .. " equipped the " .. self:getName() .. ".")
end

function LightEquipItem:onWorldUse(target)
    self.storage, self.index = Game.inventory:getItemIndex(self)
    Assets.playSound("item")
    if self.type == "weapon" then
        if target:getWeapon() then
            Game.inventory:addItemTo(self.storage, self.index, target:getWeapon())
        end
        target:setWeapon(self)
    elseif self.type == "armor" then
        if target:getArmor(1) then
            Game.inventory:addItemTo(self.storage, self.index, target:getArmor(1))
        end
        target:setArmor(1, self)
    else
        error("LightEquipItem "..self.id.." invalid type: "..self.type)
    end

    self.storage, self.index = nil, nil
    self:showEquipText(target)
    return true
end

function LightEquipItem:getLightBattleText(user, target)
    -- if user == target then
        -- return "* ".. user.chara:getNameOrYou() .. " equipped the " .. self:getUseName() .. "."
    -- else
        -- return "* "..user.chara:getNameOrYou().." gave the "..self:getUseName().." to "..target.chara:getNameOrYou(true).." and "..target.chara:getNameOrYou(true).." equppied it."
    -- end
    return "* ".. target.chara:getNameOrYou() .. " equipped the " .. self:getUseName() .. "."
end

function LightEquipItem:getBattleText(user, target)
    if user == target then
        return "* ".. target.chara:getName() .. " equipped the " .. self:getUseName() .. "!"
    else
        return "* "..user.chara:getName().." gave the "..self:getUseName().." to "..target.chara:getName().." and "..target.chara:getName().." equppied it!"
    end
end

function LightEquipItem:onLightBattleUse(user, target)
    Assets.playSound("item")
    local chara = target.chara
    if self.type == "weapon" then
        if chara:getWeapon() then
            Game.inventory:addItemTo(self.storage, self.index, chara:getWeapon())
        end
        chara:setWeapon(self)
    elseif self.type == "armor" then
        if chara:getArmor(1) then
            Game.inventory:addItemTo(self.storage, self.index, chara:getArmor(1))
        end
        chara:setArmor(1, self)
    else
        error("LightEquipItem "..self.id.." invalid type: "..self.type)
    end
    self.storage, self.index = nil, nil
    Game.battle:battleText(self:getLightBattleText(user, target))
end

function LightEquipItem:onBattleUse(user, target)
    Assets.playSound("item")
    local chara = target.chara
    if self.type == "weapon" then
        if chara:getWeapon() then
            Game.inventory:addItemTo(self.storage, self.index, chara:getWeapon())
        end
        chara:setWeapon(self)
    elseif self.type == "armor" then
        if chara:getArmor(1) then
            Game.inventory:addItemTo(self.storage, self.index, chara:getArmor(1))
        end
        chara:setArmor(1, self)
    else
        error("LightEquipItem "..self.id.." invalid type: "..self.type)
    end
    self.storage, self.index = nil, nil
end

function LightEquipItem:onLightBoltHit(battler) end
function LightEquipItem:scoreLightHit(battler, score, eval, close)
    local new_score = score
    new_score = new_score + eval

    if new_score > 430 then
        new_score = new_score * 1.8
    end
    if new_score >= 400 then
        new_score = new_score * 1.25
    end

    return new_score
end

return LightEquipItem