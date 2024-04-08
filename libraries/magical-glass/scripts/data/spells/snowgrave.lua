local spell, super = Class("snowgrave", true)

function spell:onLightCast(user, target)
    user.delay_turn_end = true
    return self:onCast(user, target)
end

return spell