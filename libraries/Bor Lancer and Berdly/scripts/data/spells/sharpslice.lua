local spell, super = Class(Spell, "sharpslice")

function spell:init()
    super.init(self)

    -- Display name
    self.name = "SharpSlice"
    -- Name displayed when cast (optional)
    self.cast_name = nil

    -- Battle description
    self.effect = "Fatal"
    -- Menu description
    self.description = "Deals fatal card damage\nto all of the enemies."

    -- TP cost
    self.cost = 200

    -- Target mode (ally, party, enemy, enemies, or none)
    self.target = "enemies"

    -- Tags that apply to this spell
    self.tags = {"card", "fatal", "damage"}
end

function spell:getTPCost(chara)
    local cost = super.getTPCost(self, chara)
    if chara and chara:checkWeapon("cardblaster") then
        cost = Utils.round(cost / 2)
    end
    return cost
end

function spell:onCast(user, target)
    local actor = user.actor
    Game.battle.music:fade(0, 1.5)
    Game.battle.timer:after(2, function()
        if not user:setAnimation("battle/pray") then
            user:setAnimation("battle/idle")
        end

        Game.battle.timer:after(1, function()

            if not user:setAnimation("battle/spell_special") then
                user:setAnimation("battle/idle")
            end
            user:slideTo(user.x, user.y - 20, 2, "out-quint")
            
            Game.battle.timer:after(1, function()
                
                local object = SharpSliceSpell(user)
                object.damage = math.ceil(((user.chara:getStat("magic") * 40) + 600))
                object.layer = BATTLE_LAYERS["above_ui"]
                Game.battle:addChild(object)

                Game.battle.timer:after(3, function()
                    user:setSprite("battle/defeat")
                    user:slideTo(user.x, user.y + 20, 1, "in-out-circ")
                    Game.battle.timer:after(1.5, function()
                        Game.battle:setState("VICTORY")
                        --Game.battle:returnToWorld()
                    end)
                end)
            end)
        end)
    end)
    return false
end

return spell