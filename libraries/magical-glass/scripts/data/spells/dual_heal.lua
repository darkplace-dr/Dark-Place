local spell, super = Class("dual_heal", true)

function spell:onLightStart(user, target)
    local amount = math.ceil(Game:isLight() and user.chara:getStat("magic") * 3.75 or user.chara:getStat("magic") * 5.5)
    for _,battler in ipairs(Game.battle.party) do
        battler:heal(amount, false, true)
    end

    local result = self:onLightCast(user, target)
    Game.battle:battleText(self:getLightCastMessage(user, target))
    if result or result == nil then
        Game.battle:finishActionBy(user)
    end
end

return spell