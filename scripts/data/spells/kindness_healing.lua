local spell, super = Class(Spell, "kindness_healing")

function spell:init()
    super.init(self)

    -- Display name
    self.name = "Kindness Healing"
    -- Name displayed when cast (optional)
    self.cast_name = "KIND HEAL"

    -- Battle description
    self.effect = "Poweful\nHealing."
    -- Menu description
    self.description = "The main power of the [color:red]SOUL[color:reset] of [color:green]Kindness[color:reset], trained to its maximal potential."

    -- TP cost
    self.cost = 65

    -- Target mode (ally, party, enemy, enemies, or none)
    self.target = "ally"

    -- Tags that apply to this spell
    self.tags = {"heal"}
end

function spell:onCast(user, target)
    target:heal(user.chara:getStat("magic") * 11)
end

return spell