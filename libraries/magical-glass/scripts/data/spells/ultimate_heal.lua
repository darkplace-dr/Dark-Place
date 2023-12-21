local spell, super = Class("ultimate_heal", true)

function spell:onLightStart(user, target)
    local amount = math.ceil(user.chara:getStat("magic"))
    target:heal(amount, false, true)

    local result = self:onLightCast(user, target)
    Game.battle:battleText(self:getLightCastMessage(user, target).."\n"..self:getHealMessage(user, target, amount))
    if result or result == nil then
        Game.battle:finishActionBy(user)
    end
end

return spell
