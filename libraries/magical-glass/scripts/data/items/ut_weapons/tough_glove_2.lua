local item, super = Class(LightEquipItem, "ut_weapons/tough_glove_2")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Tough Glove 2"
    self.short_name = "TuffGlove2"
    self.serious_name = "Glove 2"

    -- Item type (item, key, weapon, armor)
    self.type = "weapon"
    -- Whether this item is for the light world
    self.light = true

    -- Light world check text
    self.check = "Weapon AT 5\n* A worn pink leather glove.[wait:10]\nFor five-fingered folk."

    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = nil

    self.bonuses = {
        attack = 5
    }

    self.bolt_count = 4
    self.bolt_speed = 8
    self.bolt_speed_variance = nil
    self.bolt_direction = "random"
    self.bolt_miss_threshold = 22
    self.multibolt_variance = {{15}, {50}, {85}}

    self.attack_sound = "punchstrong"

    self.tags = {"punch"}

end

function item:showEquipText(target)
    Game.world:showText("* " .. target:getNameOrYou() .." equipped Tough Glove 2.")
end

function item:getLightBattleText(user, target)
    return "* "..target.chara:getNameOrYou().." equipped Tough Glove 2."
end

function item:onBoltHit(lane)
    local battler = lane.battler
    local enemy = Game.battle:getActionBy(battler).target

    Assets.playSound("punchweak")
    local small_punch = Sprite("effects/attack/hyperfist")
    small_punch:setOrigin(0.5, 0.5)
    small_punch:setScale(0.5, 0.5)
    small_punch.layer = BATTLE_LAYERS["above_ui"] + 5
    small_punch.color = battler.chara:getLightMultiboltAttackColor()
    small_punch:setPosition(enemy:getRelativePos((love.math.random(enemy.width)), (love.math.random(enemy.height))))
    enemy.parent:addChild(small_punch)
    small_punch:play(2/30, false, function(s) s:remove() end)
end

function item:onLightAttack(battler, enemy, damage, stretch, crit)
    local src = Assets.stopAndPlaySound(self:getLightAttackSound() or "laz_c")
    src:setPitch(self:getLightAttackPitch() or 1)

    local sprite = Sprite("effects/attack/hyperfist")
    sprite:setOrigin(0.5, 0.5)
    sprite:setPosition(enemy:getRelativePos((enemy.width / 2), (enemy.height / 2)))
    sprite.layer = BATTLE_LAYERS["above_ui"] + 5
    sprite.color = battler.chara.light_color -- need to swap this to the get function
    enemy.parent:addChild(sprite)
    Game.battle:shakeCamera(3, 3, 2)

    if crit then
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

        Game.battle:endAttack()

    end)
end

return item