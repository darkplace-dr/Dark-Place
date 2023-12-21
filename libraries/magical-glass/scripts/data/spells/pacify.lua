local spell, super = Class("pacify", true)

function spell:onLightCast(user, target)
    self:onCast(user, target)
end

return spell