local spell, super = Class(Spell, "ultimate_heal_ex")

function spell:init()
    super.init(self)

    -- Display name
    self.name = "UltimatHeal"
    -- Name displayed when cast (optional)
    self.cast_name = "ULTIMATEHEAL"

    -- Battle description
    self.effect = "Best\nhealing"
    -- Menu description
    self.description = "Heals 1 party member to the\nbest of Susie's ability."

    -- TP cost
    self.cost = 50

    -- Target mode (ally, party, enemy, enemies, or none)
    self.target = "ally"

    -- Tags that apply to this spell
    self.tags = {"heal"}
end

function spell:onCast(user, target)
    target:heal(user.chara:getStat("magic") * 8)
end

function spell:hasWorldUsage(chara)
    return true
end

function spell:onWorldCast(chara)
    local powa = love.math.random(30, 50)
    Game.world:heal(chara, powa)
end

return spell
