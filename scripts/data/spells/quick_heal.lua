local spell, super = Class(Spell, "quick_heal")

function spell:init()
    super.init(self)

    -- Display name
    self.name = "Quick Heal"
    -- Name displayed when cast (optional)
    self.cast_name = nil

    -- Battle description
    self.effect = "Heal\nFast"
    -- Menu description
    self.description = "* You need to go fast."

    -- TP cost
    self.cost = 25

    -- Target mode (ally, party, enemy, enemies, or none)
    self.target = "ally"
    -- Tags that apply to this spell
    self.tags = {"heal"}
end

function spell:getCastMessage(user, target)
    return "* QUICK, HEAL!!!"
end

function spell:onCast(user, target)
    local object = Quicktime(user, target)
    object.damage = self:getDamage(user, target)
    object.layer = BATTLE_LAYERS["above_ui"]
    Game.battle.timer:script(function(wait)
        wait(0.5)
        Game.battle:addChild(object)
    end)
    return false
end

function spell:getDamage(user, target)
    return 0 
end

return spell