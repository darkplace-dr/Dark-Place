local spell, super = Class(Spell, "fireball")

function spell:init()
    super.init(self)

    -- Display name
    self.name = "Fireball"

    -- Battle description
    self.effect = "Flame"
    -- Menu description
    self.description = "Deals damage to enemies."

    -- TP cost
    self.cost = 40

    -- Target mode (ally, party, enemy, enemies, or none)
    self.target = "enemy"

    -- Tags that apply to this spell
    self.tags = {"Damage"}
end

function spell:getCastMessage(user, target)
    return "* "..user.chara:getName().." used "..self:getCastName().."!"
end

function spell:onCast(user, target)
	local damage = math.floor((((user.chara:getStat("attack") * 400) / 20) - 3 * (target.defense)) * 1)
	
	target:hurt(damage, user)
	Assets.playSound("damage")
end

return spell
