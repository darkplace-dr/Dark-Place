local item, super = Class(LightEquipItem, "ut_weapons/tough_glove")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Tough Glove"
    self.short_name = "TuffGlove"
    self.serious_name = "Glove"

    -- Item type (item, key, weapon, armor)
    self.type = "weapon"
    -- Whether this item is for the light world
    self.light = true

    -- Shop description
    self.shop = "Slap 'em."
    -- Default shop price (sell price is halved)
    self.price = 50
    -- Default shop sell price
    self.sell_price = 50
    -- Whether the item can be sold
    self.can_sell = true

    -- Item description text (unused by light items outside of debug menu)
    self.description = "A worn pink leather glove.\nFor five-fingered folk."

    -- Light world check text
    self.check = "Weapon AT 5\n* A worn pink leather glove.[wait:10]\nFor five-fingered folk."

    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = nil

    self.bonuses = {
        attack = 4
    }

    self.light_bolt_speed = self.light_bolt_speed * 1.2
    self.attack_punches = 4
    self.attack_punch_time = 1
    self.light_bolt_direction = "random"

    self.attack_sound = "punchstrong"

    self.ignore_no_damage = true

    self.tags = {"punch"}

end

function item:showEquipText(target)
    Game.world:showText("* " .. target:getNameOrYou() .." equipped Tough Glove.")
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
    local state = "PRESS" -- PRESS, PUNCHING, DONE
    local punches = 0
    local punch_time = 0

    local confirm_button
    local press = Sprite("ui/lightbattle/pressz_press")
    local confirm_key = string.sub(Input.getText("confirm"), 2, -2)
    if Input.usingGamepad() then
        confirm_button = Sprite(Input.getTexture("confirm"))
        confirm_button:setScale(2)
        confirm_button:setOrigin(0.5, 0.5)
        confirm_button:setPosition(enemy:getRelativePos((enemy.width / 2), (enemy.height / 2) + 6))
    elseif confirm_key ~= "Z" then
        confirm_button = Text(confirm_key)
        confirm_button:setColor(0,1,0)
        confirm_button:addFX(OutlineFX({0,0,0}))
        confirm_button:setPosition(enemy:getRelativePos((enemy.width / 2) - 3 - (#confirm_key - 1) * 3.5, (enemy.height / 2) - 3))
    else
        confirm_button = Sprite("ui/lightbattle/pressz_z")
        confirm_button:setOrigin(0.5, 0.5)
        confirm_button:setPosition(enemy:getRelativePos((enemy.width / 2), (enemy.height / 2)))
    end
    local press_timer = 3
    press:setOrigin(0.5, 0.5)
    press:setPosition(enemy:getRelativePos((enemy.width / 2), (enemy.height / 2)))
    press:setLayer(BATTLE_LAYERS["above_ui"] + 5)
    confirm_button:setLayer(BATTLE_LAYERS["above_ui"] + 5)

    local function finishAttack()
        if press then
            press:remove()
        end
        if confirm_button then
            confirm_button:remove()
        end

        if punches > 0 then
            local sound = enemy:getDamageSound() or "damage"
            if sound and type(sound) == "string" and (damage > 0 or enemy.always_play_damage_sound) then
                Assets.stopAndPlaySound(sound)
            end
            local new_damage = math.ceil(damage * (punches / self.attack_punches))
            enemy:hurt(new_damage, battler)
    
            battler.chara:onLightAttackHit(enemy, damage)
            Game.battle:finishActionBy(battler)
        else
            self:onLightMiss(battler, enemy, false, punches)
        end

    end

    Game.battle.timer:during(self.attack_punch_time, function()
        press_timer = press_timer - 1 * DTMULT

        if press_timer < 0 then
            if press.visible == false and confirm_button.visible == false then
                press_timer = 6
                press.visible = true
                confirm_button.visible = true
            else
                press.visible = false
                confirm_button.visible = false
                press_timer = 3
            end
        end

        if Input.pressed("confirm") and state ~= "DONE" then

            if state == "PRESS" then
                enemy.parent:addChild(press)
                enemy.parent:addChild(confirm_button)
                state = "PUNCHING"
            elseif state == "PUNCHING" then

                punches = punches + 1

                if punches < self.attack_punches then
                    if press then
                        press:remove()
                    end
                    if confirm_button then
                        confirm_button:remove()
                    end

                    Assets.playSound("punchweak")
                    local small_punch = Sprite("effects/attack/regfist")
                    small_punch:setOrigin(0.5, 0.5)
                    small_punch.layer = BATTLE_LAYERS["above_ui"] + 5
                    small_punch.color = {battler.chara:getLightMultiboltAttackColor()}
                    small_punch:setPosition(enemy:getRelativePos((love.math.random(enemy.width)), (love.math.random(enemy.height))))
                    enemy.parent:addChild(small_punch)
                    small_punch:play(2/30, false, function(s) s:remove() end)
                else
                    state = "DONE"
                    local src = Assets.stopAndPlaySound(self:getLightAttackSound() or "laz_c")
                    src:setPitch(self:getLightAttackPitch() or 1)
                    
                    local punch = Sprite("effects/attack/hyperfist")
                    punch:setOrigin(0.5, 0.5)
                    punch.layer = BATTLE_LAYERS["above_ui"] + 5
                    punch.color = {battler.chara:getLightMultiboltAttackColor()}
                    punch:setPosition(enemy:getRelativePos((enemy.width / 2) - (#Game.battle.attackers - 1) * 5 / 2 + (Utils.getIndex(Game.battle.attackers, battler) - 1) * 5, (enemy.height / 2)))
                    enemy.parent:addChild(punch)
                    punch:play(2/30, false, function(s) s:remove() finishAttack() end)
                end

            end
        end
    end,
    function()
        if state ~= "DONE" then
            finishAttack()
            state = "DONE" 
        end
    end)
    return false
end

function item:onLightMiss(battler, enemy)
    enemy:hurt(0, battler, on_defeat, {battler.chara:getLightMissColor()}, true)
    Game.battle:finishActionBy(battler)
end

return item