local item, super = Class("revivemint", true)

function item:onLightBattleUse(user, target)
    local amount = 0
    if target.chara:getHealth() <= 0 then
        amount = math.abs(target.chara:getHealth()) + target.chara:getStat("health")
    else
        amount = math.ceil(target.chara:getStat("health") / 2)
    end
    target:heal(amount)
    Assets.stopAndPlaySound("power")
    Game.battle:battleText(self:getLightBattleText(user, target).."\n"..self:getLightBattleHealingText(user, target, amount))
end

return item