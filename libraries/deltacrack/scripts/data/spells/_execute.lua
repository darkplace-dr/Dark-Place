-- This spell is only used for display in the POWER menu.

local spell, super = Class(Spell, "_execute")

function spell:init()
    super.init(self)

    -- Display name
    self.name = "EXECUTE"
    -- Name displayed when cast (optional)
    self.cast_name = nil

    -- Battle description
    self.effect = ""
    -- Menu description
    self.description = "Fatal."

    -- TP cost
    self.cost = 0

    -- Target mode (ally, party, enemy, enemies, or none)
    self.target = "enemy"

    -- Tags that apply to this spell
    self.tags = {}
end

return spell