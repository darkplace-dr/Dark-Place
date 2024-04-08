local spell, super = Class("ice_shock", true)

function spell:onLightCast(user, target)
    user.delay_turn_end = true
    return self:onCast(user, target)
end

function spell:getDamage(user, target)
    if Game:isLight() then
        local min_magic = Utils.clamp(user.chara:getStat("magic") - 3, 1, 999)
        return math.ceil((min_magic * 8) + 45 + Utils.random(10))
    else
        return super.getDamage(self, user, target)
    end
end

return spell