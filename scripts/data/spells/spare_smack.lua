local spell, super = Class(Spell, "spare_smack")

function spell:init()
    super.init(self)

    -- Display name
    self.name = "Spare Smack"
    -- Name displayed when cast (optional)
    self.cast_name = nil

    -- Battle description
    self.effect = "Harmless\nSpare :)"
    -- Menu description
    self.description = "I'm gonna hit you,\nsafely of course. :)"

    -- TP cost
    self.cost = 0

    -- Target mode (ally, party, enemy, enemies, or none)
    self.target = "enemy"
    -- Tags that apply to this spell
    self.tags = {"rude", "damage"}
end

function spell:getCastMessage(user, target)
    return "* PRESS (Z)!"
end

function spell:onCast(user, target)
    local object = Slapper(user, target)
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