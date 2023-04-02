local spell, super = Class(Spell, "royalight")

function spell:init()
    super.init(self)

    -- Display name
    self.name = "RoyaLight"
    -- Name displayed when cast (optional)
    self.cast_name = nil

    -- Battle description
    self.effect = "Heals\nAlly"
    -- Menu description
    self.description = "Heals some HP. Side-effects include: heightened\nego, and bird-like cries for worm food."

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