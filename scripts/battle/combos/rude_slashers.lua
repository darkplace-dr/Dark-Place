local Forest, super = Class(Combo, "rude_slashers")

function Forest:init()
    -- Display name
    self.name = "Rude Slashers"
    -- Name displayed when cast (optional)
    self.cast_name = nil

    -- Battle description
    self.effect = ""
    -- Menu description
    self.description = "YOU and Susie slash at the enemy many times."

    -- TP cost
    self.cost = 0
    -- Whether the combo can be used
    self.usable = true

    -- Target mode (ally, party, enemy, enemies, or none)
    self.target = "none"

    -- Tags that apply to this combo
    self.tags = {}

    -- Other party members that are required to be in the party.
    self.party = {"YOU","susie"}
end

return Forest