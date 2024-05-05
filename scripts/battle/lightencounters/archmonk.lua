local ArchMonk, super = Class(LightEncounter)

function ArchMonk:init()
    super:init(self)

    self.text = "* Arch Monk raises her bow."

    self.music = "beasts"

    self:addEnemy("arch_monk")

    self.offset = 0
end

return ArchMonk