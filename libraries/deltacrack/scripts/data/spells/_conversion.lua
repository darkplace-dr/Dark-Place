-- This spell is only used for display in the POWER menu.

local spell, super = Class(Spell, "_conversion")

function spell:init()
    super.init(self)

    -- Display name
    self.name = "CONVERSION"
    -- Name displayed when cast (optional)
    self.cast_name = nil

    -- Battle description
    self.effect = ""
    -- Menu description
    self.description = "Can someone stop giving the player spells that indirectly assist their genocide route thanks"

    -- TP cost
    self.cost = 50

    -- Target mode (ally, party, enemy, enemies, or none)
    self.target = "enemy"

    -- Tags that apply to this spell
    self.tags = {}
end

return spell