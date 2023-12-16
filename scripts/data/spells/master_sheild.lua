local spell, super = Class(Spell, "master_sheild")

function spell:init()
    super.init(self)

    -- Display name
    self.name = "Master Sheild"
    -- Name displayed when cast (optional)
    self.cast_name = "KIND HEAL"

    -- Battle description
    self.effect = "Negates\ndamage."
    -- Menu description
    self.description = "The second power of the [color:red]SOUL[color:reset] of [color:green]Kindness[color:reset], near unbreakable. Depends on current HP."

    -- TP cost
    self.cost = 50

    -- Target mode (ally, party, enemy, enemies, or none)
    self.target = "ally"

    -- Tags that apply to this spell
    self.tags = {"ally"}
end

function spell:onCast(user, target)
    local power = Utils.clampMap(user.health, 0, 50, 0, 1)
    if power > 0.9 then
        power = 1
    end

    Game.battle.shield_data = {
        target = target,
        unbreakable_level = power
    }
end

function spell:getTPCost(chara)
    return Utils.clamp(self.cost + chara.health, 50, 100)
end

function spell:hasWorldUsage(chara)
    return true
end

function spell:onWorldCast(chara)
    Game.world:heal(chara, 999999)
end

return spell