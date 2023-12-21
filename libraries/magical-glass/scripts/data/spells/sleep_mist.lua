local spell, super = Class("sleep_mist", true)

function spell:onLightCast(user, target)
    self:onCast(user, target)
end

return spell