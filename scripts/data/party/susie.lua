local character, super = Class("susie", true)

function character:init()
    super.init(self)

    self:addSpell("pacify")
end

return character