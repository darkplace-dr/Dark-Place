local spell, super = Class("snowgrave", true)

function spell:onLightCast(user, target)
    return self:onCast(user, target)
end

return spell