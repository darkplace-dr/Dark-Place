local item, super = Class(LightEquipItem, "ut_weapons/ballet_shoes")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Ballet Shoes"
    self.short_name = "BallShoes"
    self.serious_name = "Shoes"

    -- Item type (item, key, weapon, armor)
    self.type = "weapon"
    -- Whether this item is for the light world
    self.light = true

    -- Default shop sell price
    self.sell_price = 80
    -- Whether the item can be sold
    self.can_sell = true

    -- Item description text (unused by light items outside of debug menu)
    self.description = "These used shoes make you feel extra dangerous."

    -- Light world check text
    self.check = "Weapon AT 7\n* These used shoes make you feel\nextra dangerous."

    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = nil

    self.bonuses = {
        attack = 7
    }

    self.light_bolt_count = 3
    self.light_bolt_speed = 10
    self.light_bolt_speed_variance = nil
    self.light_bolt_start = -90
    self.light_bolt_miss_threshold = 2
    self.light_bolt_direction = "right"
    self.light_multibolt_variance = {{0, 25, 50}, {100, 125, 150}}

    self.attack_sound = "punchstrong"
end

function item:showEquipText(target)
    Game.world:showText("* " .. target:getNameOrYou().." equipped Ballet Shoes.")
end

function item:getLightBattleText(user, target)
    -- if user == target then
        -- return "* ".. user.chara:getNameOrYou() .. " equipped " .. self:getUseName() .. "."
    -- else
        -- return "* "..user.chara:getNameOrYou().." gave "..self:getUseName().." to "..target.chara:getNameOrYou(true).." and ".. target.chara:getNameOrYou(true) .. " equipped it."
    -- end
    return "* ".. target.chara:getNameOrYou() .. " equipped " .. self:getUseName() .. "."
end

function item:onLightAttack(battler, enemy, damage, stretch, crit)
    local src = Assets.stopAndPlaySound(self:getLightAttackSound() or "laz_c")
    src:setPitch(self:getLightAttackPitch() or 1)

    local sprite = Sprite("effects/attack/hyperfoot")
    sprite:setOrigin(0.5, 0.5)
    sprite:setPosition(enemy:getRelativePos((enemy.width / 2) - (#Game.battle.attackers - 1) * 5 / 2 + (Utils.getIndex(Game.battle.attackers, battler) - 1) * 5, (enemy.height / 2)))
    sprite.layer = BATTLE_LAYERS["above_ui"] + 5
    sprite.color = {battler.chara:getLightMultiboltAttackColor()}
    enemy.parent:addChild(sprite)
    Game.battle:shakeCamera(3, 3, 2)

    if crit then
        sprite:setColor(1, 1, 130/255)
        Assets.stopAndPlaySound("saber3", 0.7)
    end

    Game.battle.timer:during(1, function() -- can't even tell if this is accurate
        sprite.x = sprite.x - 2 * DTMULT
        sprite.y = sprite.y - 2 * DTMULT
        sprite.x = sprite.x + Utils.random(4) * DTMULT
        sprite.y = sprite.y + Utils.random(4) * DTMULT
    end)

    sprite:play(2/30, false, function(this) -- timing may still be incorrect    
        local sound = enemy:getDamageSound() or "damage"
        if sound and type(sound) == "string" and (damage > 0 or enemy.always_play_damage_sound) then
            Assets.stopAndPlaySound(sound)
        end
        enemy:hurt(damage, battler)

        battler.chara:onLightAttackHit(enemy, damage)
        this:remove()

        Game.battle:finishActionBy(battler)
    end)

    return false
end

return item