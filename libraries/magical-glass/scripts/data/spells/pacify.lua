local spell, super = Class("pacify", true)

function spell:onLightCast(user, target)
    if target.tired then
        self:onCast(user, target)
    end
end

return spell