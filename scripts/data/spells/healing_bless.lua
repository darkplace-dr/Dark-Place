local spell, super = Class(Spell, "healing_bless")

function spell:init()
    super.init(self)

    -- Display name
    self.name = "HealingBless"
    -- Name displayed when cast (optional)
    self.cast_name = "HEALING BLESS"

    -- Battle description
    self.effect = "Heal\nAlly"
    -- Menu description
    self.description = "Blesses one party member and grants\nsmall healing. Depends on Magic."

    -- TP cost
    self.cost = 32

    -- Target mode (ally, party, enemy, enemies, or none)
    self.target = "ally"

    -- Tags that apply to this spell
    self.tags = {"heal"}
end

function spell:onCast(user, target)
    target:heal(user.chara:getStat("magic") * 5)
end

return spell