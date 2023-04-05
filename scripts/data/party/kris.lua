local character, super = Class("kris", true)

function character:init()
    super.init(self)

    self.has_spells = true

    self.has_xact = false

    self:addSpell("xslash")
end

return character