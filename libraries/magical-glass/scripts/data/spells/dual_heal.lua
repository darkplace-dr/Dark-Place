local spell, super = Class("dual_heal", true)

function spell:onLightStart(user, target)
    local amount = math.ceil(user.chara:getStat("magic") * 2.75)
    for _,battler in ipairs(Game.battle.party) do
        battler:heal(amount)
    end

    local result = self:onLightCast(user, target)
    Game.battle:battleText(self:getLightCastMessage(user, target).."\n"..self:getHealMessage(user, target, amount))
    if result or result == nil then
        Game.battle:finishActionBy(user)
    end
end

return spell