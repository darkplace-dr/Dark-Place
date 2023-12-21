local spell, super = Class("red_buster", true)

function spell:onLightCast(user, target)
    Game.battle.timer:after(15/30, function()
        Assets.playSound("rudebuster_swing")
        local x, y = (SCREEN_WIDTH/2), SCREEN_HEIGHT + 250
        local tx, ty = target:getRelativePos(target.width/2, target.height/2, Game.battle)
        local blast = LightRudeBusterBeam(true, x, y, tx, ty, function(pressed)
            local damage = self:getDamage(user, target, pressed)
            if pressed then
                Assets.playSound("scytheburst")
            end
            target:hurt(damage, user)
            Game.battle:finishAction()
        end)
        blast.layer = BATTLE_LAYERS["above_ui"]
        Game.battle:addChild(blast)
    end)
    return false
end

function spell:getDamage(user, target, pressed)
    if Game.battle.light then
        local damage = math.ceil((user.chara:getStat("magic") * 4) + (user.chara:getStat("attack") * 8) - (target.defense * 4)) + 70
        if pressed then
            damage = damage + 20
        end
        return damage
    else
        local damage = math.ceil((user.chara:getStat("magic") * 6) + (user.chara:getStat("attack") * 13) - (target.defense * 6)) + 90
        if pressed then
            damage = damage + 30
        end
        return damage
    end
end

return spell